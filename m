Content-Type: multipart/mixed; boundary="===============3642597199568268560=="
MIME-Version: 1.0
From: 'Christoph Paasch' <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC] MPTCP Path Management Generic Netlink API
Date: Tue, 13 Mar 2018 11:26:06 -0700
Message-ID: <20180313182606.GI74937@MacBook-Pro-4.local>
In-Reply-To: 01fe01d3ba45$c830fdc0$5892f940$@froemmgen.de
X-Status: 
X-Keywords:                  
X-UID: 372

--===============3642597199568268560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/03/18 - 22:04:59, Alexander Fr=C3=B6mmgen wrote:
> Hi
> =

> > How do you plan to handle schedulers? Given the good experimental resul=
ts
> of the min-RTT-first scheduler, will that be the only option? Or will it
> remain as a kernel module due to the time-sensitive nature of scheduling?
> =

> We experimented with a programmable scheduler in the Kernel, which enables
> timely scheduling decisions and a lot of flexibility. Details are availab=
le
> at https://progmp.net and you might want to directly test a scheduler at
> http://progmp.net/progmp.html =

> =

> Our current setup contains a lot of additional logic in the Kernel (e.g.,
> lexer, parser). While this has some benefits, I think that the eBPF-based
> part of our work should be sufficient  for most application scenarios.

I would love to see a patch-submission :-)


Cheers,
Christoph


--===============3642597199568268560==--
