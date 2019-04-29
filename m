Content-Type: multipart/mixed; boundary="===============8890212418134838377=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP architecture proposal - RFCv10 changes pushed
Date: Mon, 29 Apr 2019 16:25:51 -0700
Message-ID: <alpine.OSX.2.21.1904291616570.5723@mjmartin-mac01.local>
X-Status: 
X-Keywords:                  
X-UID: 1101

--===============8890212418134838377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

I have pushed an update to the MPTCP kernel architecture proposal:

https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmptcp-proposal


The commit ID for RFCv10 is 6cfe3336cf01a64e45d66124f3ff768cab0df1bd


Changes:

1) Split the mptcp.h header file

2) Refined handling CONFIG_MPTCP vs non-CONFIG_MPTCP builds

3) Refactored option writing code to minimize changes in tcp_output.c and =

avoid using magic numbers

4) Added ULP clone hook and modified MPTCP subflow cloning to use it

5) Florian's namespacing fix and conn_finished fix (rx dst update crash)

6) Fix locking in mptcp_recvmsg()


Regards,

--
Mat Martineau
Intel

--===============8890212418134838377==--
