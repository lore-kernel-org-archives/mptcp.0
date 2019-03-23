Content-Type: multipart/mixed; boundary="===============7490876545179043252=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP architecture proposal - RFCv8 changes pushed
Date: Fri, 22 Mar 2019 17:14:59 -0700
Message-ID: <alpine.OSX.2.21.1903221708230.45625@kasilva-mobl3.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1033

--===============7490876545179043252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Hello -

I've pushed a new revision of the MPTCP kernel architecture proposal:

https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmptcp-proposal


Changes:

  * Added Paolo's self test change (Note: I made minor changes to remove =

some unused variables)

  * Various changes and refactoring based on gerrithub code review. These =

mostly reduce the impact on core TCP and improve naming and code =

organization. Thanks for all the comments!


Regards,

--
Mat Martineau
Intel

--===============7490876545179043252==--
