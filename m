Content-Type: multipart/mixed; boundary="===============8079493755463428669=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/2] mptcp: some fallback fixes
Date: Mon, 12 Oct 2020 10:01:10 +0200
Message-ID: <c5ea3f4a906c0dcd7b53b0dd70fc13eb3d2386e2.camel@redhat.com>
In-Reply-To: 20201010111332.3ac29a5f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 6286

--===============8079493755463428669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-10-10 at 11:13 -0700, Jakub Kicinski wrote:
> On Fri,  9 Oct 2020 18:59:59 +0200 Paolo Abeni wrote:
> > pktdrill pointed-out we currently don't handle properly some
> > fallback scenario for MP_JOIN subflows
> > =

> > The first patch addresses such issue.
> > =

> > Patch 2/2 fixes a related pre-existing issue that is more
> > evident after 1/2: we could keep using for MPTCP signaling
> > closed subflows.
> =

> Applied, thanks Paolo.
> =

> You already have a few of those in the code, but:
> =

> +	if (... &&
> +	    schedule_work(&mptcp_sk(sk)->work))
> +		sock_hold(sk);
> =

> isn't this a fairly questionable construct?
> =

> You take a reference for the async work to release _after_ you
> scheduled the async work? =


Thank you for reviewing! Indeed we need to add some comments there:
IIRC that chunk already raised a question in the past.

Afaics, that is safe because the caller (a subflow) held a reference to
sk and sk can't be freed in between the scheduling and the next
sock_hold(). =


We have a pending refactor, targeting the next development cycle, that
will consolidate the workqueue scheduling into an helper. We will add
some comments there to clarify the above.

Thanks,

Paolo

--===============8079493755463428669==--
