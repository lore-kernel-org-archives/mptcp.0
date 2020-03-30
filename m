Content-Type: multipart/mixed; boundary="===============0362742436271585530=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/1] selftests:mptcp: fix failure due to
 whitespace damage
Date: Mon, 30 Mar 2020 16:23:53 +0200
Message-ID: <20200330142354.563259-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4108

--===============0362742436271585530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

David: it seems that some trailing whitespaces were removed by one of
your scripts when applying eedbc685321b (selftests: add PM netlink
functional tests).

This causes a self test failure because the expected result in the
script has been modified.

We do think that it is best not having trailing whitespaces in the code
and that's why we are proposing here a new version without them. The
documentation also ask us not to leave unexepected trailing whitespace
at the end of lines.

But we simply want to ask you this question: Is it normal that these
trailing whitespaces are automatically removed? We understand if it is
and it would make sense somehow but just in case it is not normal, we
prefer to raise the question and avoid other people hitting the same
issue we had :)

Matthieu Baerts (1):
  selftests:mptcp: fix failure due to whitespace damage

 tools/testing/selftests/net/mptcp/pm_netlink.sh | 12 ++++++------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

-- =

2.25.1

--===============0362742436271585530==--
