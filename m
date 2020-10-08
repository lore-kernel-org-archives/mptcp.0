Content-Type: multipart/mixed; boundary="===============0034060855382276053=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: skip to next candidate if
 subflow has unacked data
Date: Fri, 09 Oct 2020 00:40:59 +0200
Message-ID: <20201008224059.GB5723@breakpoint.cc>
In-Reply-To: alpine.OSX.2.23.453.2010081452440.49214@ozore-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6260

--===============0034060855382276053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> We can still get inconsistent retransmission behavior depending on the or=
der
> of subflows in the list - if the first non-loss subflow has an empty write
> queue then retransmission will happen even if other subflows have queued
> data. I suppose this causes the opposite problem, retransmitting when it
> should wait. Better to handle a fix for that separately?

Yes, if we observe too many bogus retransmits then the mptcp-level
retransmit timer is firing too early, i'd say thats a different bug.
--===============0034060855382276053==--
