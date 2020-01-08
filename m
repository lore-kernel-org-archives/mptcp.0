Content-Type: multipart/mixed; boundary="===============6385563640935231912=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Rebase request
Date: Tue, 07 Jan 2020 17:31:56 -0800
Message-ID: <a54a945303550dd8ed624bb8801cdb3a780198d2.camel@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3283

--===============6385563640935231912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


I would like to switch the order of the two commits: "Add path manager
interface" and "Add ADD_ADDR handling". The addition of ADD_ADDR option
handling and adding the path manager interface is muddled between these two
commits, this switch will clean this up and make further patches for
optimizing mptcp_options_received structure cleaner.

I've done the work here:

https://github.com/pkrystad/mptcp_net-next/tree/switched-0107

git diff 3f1306e95e7a..ecd861ac7dc9 (updated export branch today) is no
changes, I only modified the two affected commits.

Matthieu: let me know how you want to proceed.

And Happy New Year everyone!

Peter.


--===============6385563640935231912==--
