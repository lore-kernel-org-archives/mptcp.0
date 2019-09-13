Content-Type: multipart/mixed; boundary="===============6481442327428768711=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH selftests 0/5] selftests: prepare for mptcp ipv6
 support
Date: Fri, 13 Sep 2019 11:45:23 +0200
Message-ID: <20190913094528.3163-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1837

--===============6481442327428768711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series inceases self test coverage:

1. ipv6 support.  So all someone needs to do is actually implement ipv6
   support in mptcp.  Then, set ipv6=3Dtrue in the selftest script and it
   should 'just work'.
2. Check accept/getpeername.  In case of connect side, we also check
   that getpeername returned addresses are the ones we connected to.
3. less predictable topology: tso/gso/gro and tc parameters are more
   random.

I suggest to apply them with no squashing, once we go for another RFC
tests/selftest can be a single patch and all commits can be squashed.

If you disagree, I don't mind if this gets squashed right away.

No changes to mptcp stack itself here.



--===============6481442327428768711==--
