Content-Type: multipart/mixed; boundary="===============0433779663302528273=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: use-after-free Write in __lock_sock
Date: Tue, 04 Feb 2020 07:55:18 +0100
Message-ID: <20200204065518.GC15904@breakpoint.cc>
In-Reply-To: 20200204002459.GB33105@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3579

--===============0433779663302528273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch <cpaasch(a)apple.com> wrote:
> On 04/02/20 - 00:59:08, Florian Westphal wrote:
> > So, in case you get a similar/different repro I'd be grateful if you
> > could forward that one to the ML as well.
> =

> Sure - here is another repro that triggers immediatly on my kvm.
> =

> Attached is also the .config I use.
> =

> This is on the export-branch, rebased on latest linux-next (otherwise my =
kvm
> doesn't even boot).

Ah, I tried net.git only; i get a crash on mptcp-next.

Thanks for the repro.

Davide, Paolo -- let me know if you are already working on it, otherwise
I will start working on a fix later today.
--===============0433779663302528273==--
