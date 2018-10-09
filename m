Content-Type: multipart/mixed; boundary="===============0405831967301651560=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP layer processing overhead?!
Date: Tue, 09 Oct 2018 15:17:00 -0700
Message-ID: <20181009221700.GS36310@MacBook-Pro-19.local>
In-Reply-To: CAG40BELokRB53D3jdUP6kx8B1B=+J8Ycn3Y+rN5jBjKhyURA2g@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 802

--===============0405831967301651560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/10/18 - 23:59:19, Dejene Boru wrote:
> Hi all,
> =

> My understanding from MPTCP protocol is that, if MPTCP has only one subfl=
ow
> it behaves almost similar to regular TCP with Reno  congestion control.
> This means that if I enable MPTCP but set the  congestion control for
> example to BBR or DCTCP configuring the parameters required for the
> respective congestion control, it should be able to achieve the same
> throughput as when MPTCP is disabled and the corresponding congestion
> control is configured. I have tested MPTCP with  one subflow  using DCTCP
> congestion control and obtained a 10% reduced throughput compared with
> MPTCP disabled.  Which part of the MPTCP code does result in this kind of
> overhead?

Are you CPU-limited here in this scenario?

What throughput are you getting exactly?


Christoph


--===============0405831967301651560==--
