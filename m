Content-Type: multipart/mixed; boundary="===============6662941050632242769=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 09/10] Use pm_get_local_id() to get the real
 local address id.
Date: Fri, 02 Aug 2019 16:50:19 +0200
Message-ID: <06203b401e199bb57d9623828414a3be5bda3206.camel@redhat.com>
In-Reply-To: 85a5ecdc57fdf6ec3dc2f1bf3ff3eaf405408327.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1581

--===============6662941050632242769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-02 at 16:42 +0200, Paolo Abeni wrote:
> Perhaps adding a new helper, alike 'token_lookup_get()' would help.

I should have looked first at the last patch in the series.

The function 'token_lookup()' implemented in 10/10 would do.

My personal taste - notoriously not good, still - is that functions
name is a little confusing. How about:

s/lookup_token/__token_lookup/

because requires leave to the caller acquiring the needed locking

s/token_lookup/token_lookup_get/

because also get a reference to the returned sock

?



--===============6662941050632242769==--
