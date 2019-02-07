Content-Type: multipart/mixed; boundary="===============5012280372418474304=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC mptcp 0/4] mptcp: kselftest program and a few bugs
Date: Thu, 07 Feb 2019 15:27:07 +0100
Message-ID: <20190207142711.3475-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 989

--===============5012280372418474304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi.

First patch adds a small mptcp test program, nothing fancy,
just transmits stdin via mptcp connection and back out again.

Uncovers a few issues, the one unfixed is that
read(mptcpfd, buf, buflen)

can return cause data to be discarded.
In that case, read() returns a value larger than "buflen".
Did not investigate further so far.

Other issues found are handled in the remaining patches.

I'll be attending the conf call later today, so we can continue
discussion there if needed.



--===============5012280372418474304==--
