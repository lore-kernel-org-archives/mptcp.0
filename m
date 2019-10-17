Content-Type: multipart/mixed; boundary="===============4713276143469223188=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] mptcp: add and use
 mptcp_subflow_get_retrans
Date: Thu, 17 Oct 2019 15:12:57 +0200
Message-ID: <3087acbf87d2e052c42e2e3cc0b94dbb6f32d8e6.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1910161621460.4400@jodiswax-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2209

--===============4713276143469223188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-16 at 17:26 -0700, Mat Martineau wrote:
> As this email thread shows, there are a lot of potential inputs for makin=
g =

> a scheduling decision and there isn't a one-size-fits all scheduling =

> algorithm. The multipath-tcp.org kernel handles this with different =

> scheduler modules, and we do have configurable schedulers later in the =

> roadmap.
> =

> My suggestion is to keep it very, very simple for now!

Agreed.

I really should fight harder my tendency to overdesign ;)

Let's go the this path and ev. we can adjust later, if needed.

Thanks,

Paolo

--===============4713276143469223188==--
