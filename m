Content-Type: multipart/mixed; boundary="===============8164036155826719731=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 09/10] Use pm_get_local_id() to get the real
 local address id.
Date: Wed, 07 Aug 2019 15:12:04 -0700
Message-ID: <0c0038cdf5bd37bdc729dee2b4b7b002ca5ff031.camel@linux.intel.com>
In-Reply-To: 06203b401e199bb57d9623828414a3be5bda3206.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1604

--===============8164036155826719731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-02 at 16:50 +0200, Paolo Abeni wrote:
> On Fri, 2019-08-02 at 16:42 +0200, Paolo Abeni wrote:
> > Perhaps adding a new helper, alike 'token_lookup_get()' would help.
> =

> I should have looked first at the last patch in the series.
> =

> The function 'token_lookup()' implemented in 10/10 would do.
> =

> My personal taste - notoriously not good, still - is that functions
> name is a little confusing. How about:
> =

> s/lookup_token/__token_lookup/
> =

> because requires leave to the caller acquiring the needed locking
> =

> s/token_lookup/token_lookup_get/
> =

> because also get a reference to the returned sock
> =

> ?

I will rename token_lookup() from patch 10 to token_lookup_get() to reflect
that it takes a reference.

I will rename the static helper 'lookup_token' to '__token_lookup' (swapping
words really was a horrible bit of naming). However since this change will
need to be several commits that can be squashed to different places I will
submit it as a separate patchset.

Peter.

> =

> =



--===============8164036155826719731==--
