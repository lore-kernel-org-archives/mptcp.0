Content-Type: multipart/mixed; boundary="===============1750655605613056881=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/3] mptcp: flush duplicate data at
 data_ready() time
Date: Tue, 15 Oct 2019 16:08:15 +0200
Message-ID: <f6ac039349454cd3669a75b00cde9a7a924d9989.camel@redhat.com>
In-Reply-To: cdc98748c1bcea2201f626496205b68aa53d6bde.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2146

--===============1750655605613056881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 12:47 +0200, Paolo Abeni wrote:
> On Mon, 2019-10-14 at 16:28 -0700, Mat Martineau wrote:
> > > +		if (subflow->map_seq !=3D mpext->data_seq ||
> > > +		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
> > > +		    subflow->map_data_len < mpext->data_len) {
> > =

> > Should this instead invalidate the mapping when subflow->map_data_len > =

> > mpext->data_len ?
> =

> uhmm... this code followed some discussion on the ML and a few mtgs
> ago.  My [mis]understanding is that we can[/want] be quite strict about
> map replacing: allowing it only if the old and the new maps are
> identical.

I'm sorry, I misread your comment. Please ignore my previous answer.

Yep, I agree invalidating the mapping even with subflow->map_data_len >
mpext->data_len, I'll do in the next iteration.

Thanks!

/P

--===============1750655605613056881==--
