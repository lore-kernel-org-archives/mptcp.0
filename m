Content-Type: multipart/mixed; boundary="===============8343431945523639509=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/10] selftests: IPv6 by default and time
 reduction
Date: Sat, 16 Nov 2019 14:41:40 +0100
Message-ID: <20191116134140.GL19558@breakpoint.cc>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2572

--===============8343431945523639509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Here are a few improvements in the selftests. Nothing complex, some
> details to have the results more readable (I think), IPv6 enabled by
> default, the time of the execution is reduced (around 30 seconds now
> with the same launched tests), and the script is more robust for the
> future.
> =

> I hope we can apply the one before the last one: IPV6 is now forced in
> the config, we can then always apply the IPv6 network config and remove
> a lot of 'if $ipv6' in the code.
> =

> For the last one, I guess we should not apply it now because some tests
> are really slow in some conditions. More details in the patch and a
> separated email has been sent.
> =

> All the patches can be squashed in the commit introducing the selftests:
> =

>   mptcp: add basic kselftest for mptcp

These look good, thanks Matthieu.
--===============8343431945523639509==--
