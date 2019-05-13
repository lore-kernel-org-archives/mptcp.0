Content-Type: multipart/mixed; boundary="===============2363397884301656398=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 0/3] mptcp: plug mptcp_accept memory leaks
Date: Mon, 13 May 2019 14:21:38 +0200
Message-ID: <20190513122141.25396-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1149

--===============2363397884301656398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series resolves the memory leaks that occur when running
mptcp_connect.sh.

I don't mind if they get squashed.
I've decided to split this into 3 distinct changes to make it
a bit clearer what is going on.

Second patch is not a bug fix, i can resend and drop it if
the consensus is to continue using the sk->sk_socket back reference.

Third patch is a bit large due to the change in how the new mptcp
socket is created.

See the commit messages for more details.
After these changes kmemleak doesn't report any leaks when the
test script has completed.

Cheers,
Florian



--===============2363397884301656398==--
