Content-Type: multipart/mixed; boundary="===============7239827693603958654=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/2] mptcp: receive buffer auto-tuning
Date: Wed, 10 Jun 2020 13:55:32 +0200
Message-ID: <20200610115534.17417-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4634

--===============7239827693603958654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First patch adds switch to test script so it can be run with a fixed
file size rather than a random one.

Second patch adds receive buffer autotuning.  I rebased this on top
of mptcp-next as per Christophs patch suggestion to make sure the
initialisation function has been run for the fallback case too.

I suggest to apply this to mptcp-next so this can be pushed to net-next
once that opens up again.


--===============7239827693603958654==--
