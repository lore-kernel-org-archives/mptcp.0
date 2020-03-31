Content-Type: multipart/mixed; boundary="===============4165818868295949420=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] general protection fault in
 __mptcp_flush_join_list
Date: Tue, 31 Mar 2020 02:27:19 +0200
Message-ID: <20200331002719.GE23604@breakpoint.cc>
In-Reply-To: 20200329181412.GB14672@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4112

--===============4165818868295949420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch <cpaasch(a)apple.com> wrote:
> Hello,
> =

> another one - on top of 402d1b0dc2e1 (yes, it's a week old - I wanted to
> let syzkaller deep-dive a bit).

Thanks for reporting, tcp fallback is buggy, we trip because msk is
tcp_sk.  No idea yet how to fix this other than hooking into
inet_accept() :(
--===============4165818868295949420==--
