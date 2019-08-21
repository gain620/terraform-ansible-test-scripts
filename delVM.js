const execSync = require('child_process').execSync;

function testSyncCommand(commandStr) {
	const stdout = execSync(commandStr, {encoding: 'utf8'});

	console.log(`stdout = ${stdout}`);

}


let cmd1 = 'cd /home/john/terraform-scripts/';
let terraCmd = `${cmd1}; terraform destroy -auto-approve`;
let delCmd = 'rm terraform.tfstate*';

//testSyncCommand(cmd1);
console.log('Moments of silence, while resources are being destroyed :(');
testSyncCommand(terraCmd);
//testSyncCommand(delCmd);
