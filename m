Content-Type: multipart/mixed; boundary="===============4964146136596812978=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] LPC proposal draft
Date: Sat, 07 Jul 2018 22:47:57 -0700
Message-ID: <20180708054757.GK1471@MacBook-Pro-19.local>
In-Reply-To: alpine.OSX.2.21.1807061510550.33244@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 676

--===============4964146136596812978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat,

this looks good to me! Let's discuss on Wednesday in Montreal before the
deadline.


Cheers,
Christoph

On 06/07/18 - 15:22:14, Mat Martineau wrote:
> =

> Hello -
> =

> Those of us in the weekly web conference yesterday discussed options for a
> Linux Plumber's Conference networking track talk
> (http://vger.kernel.org/lpc-networking.html). The deadline is coming up v=
ery
> soon, on Wednesday, 11 July.
> =

> Here's a draft proposal, please comment!
> =

> """
> =

> Implementing Multipath TCP requires both adding a layer above TCP and
> modifying the core in a number of places. The layer additions are relativ=
ely
> straightforward: adding a new IPPROTO_MPTCP protocol type, overriding
> existing callbacks from the IP layer, and adding to TCP option handling. =
But
> even after extensive efforts to minimize changes to the TCP core there ar=
e a
> handful of modifications required in order to support MPTCP. Unlike
> protocols that layer cleanly entirely above TCP, MPTCP must integrate with
> low-level TCP operations involving receive windows, sending and receiving
> ACKs, and the RST and FIN signals. We will show where the TCP core will be
> affected, why the changes cannot be avoided, and what we have done to avo=
id
> impacting TCP performance.
> =

> """
> =

> --
> Mat Martineau
> Intel OTC

--===============4964146136596812978==--
