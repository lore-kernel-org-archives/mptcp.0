Content-Type: multipart/mixed; boundary="===============6710410805631957445=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 01/10] Extend path manager interface
Date: Thu, 22 Aug 2019 15:31:15 -0700
Message-ID: <39c07dc34dd445382e948ed152ce5d608fdc69db.camel@linux.intel.com>
In-Reply-To: 00fc29d4-31e5-f365-c2fc-c741e6c17b39@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1683

--===============6710410805631957445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Matthieu -

It seems a hunk went missing when this was split and squashed. The following
piece of code from this patch does not appear in mptcp_incoming_options() in
the current export branch as I would expect to.

+       if (msk && mp_opt->add_addr) {
+               if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
+                       pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
+#if IS_ENABLED(CONFIG_IPV6)
+               else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
+                       pm_add_addr6(msk, &mp_opt->addr6, mp_opt->addr_id);
+#endif
+               mp_opt->add_addr =3D 0;
+       }
+

This causes the received ADD_ADDR option to not be passed up to the path
manager. I'll send a patch.

Peter.




On Mon, 2019-08-12 at 21:35 +0200, Matthieu Baerts wrote:
> Hi Peter, Paolo, Mat,
> =

> On 08/08/2019 00:44, Peter Krystad wrote:
> > A little more functionality and some comments clarifying
> > which routines are for a path manager to call and which are
> > callbacks.
> > =

> > squashto: Add path manager interface
> =

> Thank you for the patch and the reviews!
> =

> I had to split this patch in 2 parts:
> - c8625a37c692: part 1: "squashed" in "mptcp: Add path manager interface"
> - 4412b8e8e6c9: conflict in t/mptcp-Add-ADD_ADDR-handling
> - 0757aec1b6f2: part 2: "squashed" in "mptcp: Add ADD_ADDR handling"
> - b1477322bbb7..711ae3fdd44f: results
> =

> Cheers,
> Matt
> =



--===============6710410805631957445==--
