Content-Type: multipart/mixed; boundary="===============4193669756858346060=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp v3 0/3] mptcp: plug mptcp_accept memory leaks
Date: Thu, 16 May 2019 11:23:48 +0200
Message-ID: <20190516092351.9741-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1186

--===============4193669756858346060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3: rebase & fix erroneous conditional in patch #3.

v2 cover letter:
v2:
- rename helper in patch 2
- add back crucial mptcp_init_sock() after clone in patch 3.
  This was lost during rebase and broke the tests but i forgot
  to refresh this patch when i sent v1.                     =


This series resolves the memory leaks that occur when running
mptcp_connect.sh.

I don't mind if they get squashed.
I've decided to split this into 3 distinct changes to make it
a bit clearer what is going on.  =


Second patch is not a bug fix, i can resend and drop it if
the consensus is to continue using the sk->sk_socket back reference.

Third patch is a bit large due to the change in how the new mptcp
socket is created.

See the commit messages for more details.                      =

After these changes kmemleak doesn't report any leaks when the  =

test script has completed.



--===============4193669756858346060==--
