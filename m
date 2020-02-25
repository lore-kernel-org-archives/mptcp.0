Content-Type: multipart/mixed; boundary="===============0026043524152375242=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 1/7] mptcp: mptcp: update mptcp ack
 sequence outside of recv path
Date: Tue, 25 Feb 2020 18:16:52 +0100
Message-ID: <20200225171659.4807-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3792

--===============0026043524152375242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v1:
- in patch 6, need READ_ONCE() when reading ->owner.
  in mptcp_data_ready, call sk->sk_data_ready(sk) to wake up
  the user last.  Also update the commit message.

This helps specifically when using blocking i/o:
sk->sk_data_ready(sk) wakes up the sleeping process that waited
for data, best if we can update the mptcp receive queue before it.

- Squashed the last two patches.

I plan to send this to netdev@ wednesday morning CET.


--===============0026043524152375242==--
