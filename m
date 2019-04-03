Content-Type: multipart/mixed; boundary="===============5136362826855532337=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP architecture proposal - RFCv9 changes pushed
Date: Wed, 03 Apr 2019 16:37:27 -0700
Message-ID: <alpine.OSX.2.21.1904031628360.32059@mjmartin-mac01.local>
X-Status: 
X-Keywords:                  
X-UID: 1042

--===============5136362826855532337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

I've pushed another revision of the MPTCP kernel architecture proposal:


https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmptcp-proposal

(commit b0afc0265a8b8d95d01cbe50df05ea71f92f49cd for both)


Changes:

   * Peter has modified the internal subflow sockets to use ULP

   * Fixed building without CONFIG_MPTCP

   * Modified self-test commits to account for removal of IPPROTO_SUBFLOW


Regards,

--
Mat Martineau
Intel

--===============5136362826855532337==--
