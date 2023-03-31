Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE923BC
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 10:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680257347; x=1711793347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orqfeghqH4zHO2/uMXU2ntP81yDrZCI5FsJrO4csPzg=;
  b=rrTVhMvmFOepEpTRNqBdCJG+teOuYJbE8qpzDqRvLnSAPBeyLggvmcrq
   MEc7/LP7SWrWsqPtu8+ZjtCVhulwsXnZ97F32TXYIp8o0bhVKr14GY6FP
   WjtScGiupCU6ZRcGbIqg1KZshfu6K+/7vF+++JOIY609kZABfRsSDhqG3
   bvXVYFZw4zEikxpV0Tljgt0gHbL/IxUBRHIvPNLKQmAWDypuSmUrufsP+
   2f68X2b6vLdLOBBvCnHXWN0lh9it52XjuWOj/XvKyrLKRo+rLeRRlXNZi
   RkTVKt2Ns+6b+Yn7G0IKMVeznfHaRlwJp2GVsbQ8aGpL/7Ywc+FlyM62A
   g==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="asc'?scan'208";a="207166712"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 03:08:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 03:08:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 03:08:56 -0700
Date: Fri, 31 Mar 2023 11:08:43 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Thorsten Leemhuis <linux@leemhuis.info>
CC: Matthieu Baerts <matthieu.baerts@tessares.net>, Jonathan Corbet
	<corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, Joe Perches
	<joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>, Kai =?iso-8859-1?Q?Wasserb=E4ch?=
	<kai@dev.carbon-project.org>, Andrew Morton <akpm@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>, Bagas Sanjaya
	<bagasdotme@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <mptcp@lists.linux.dev>
Subject: Re: [PATCH v3 0/4] docs & checkpatch: allow Closes tags with links
Message-ID: <cf5a3e73-c97d-4f98-80d7-4bcc68eb557a@spud>
References: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
 <2194d19d-f195-1a1e-41fc-7827ae569351@leemhuis.info>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sMLH2/sMXXEvCsA+"
Content-Disposition: inline
In-Reply-To: <2194d19d-f195-1a1e-41fc-7827ae569351@leemhuis.info>

--sMLH2/sMXXEvCsA+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 11:39:22AM +0200, Thorsten Leemhuis wrote:

> -Please check the link to make sure that it is actually working and points
> -to the relevant message.
> +If the URL points to a bug report that is fixed by the patch, use 'Close=
s:'
> +instead.

This is not specifically a comment about your additional diff, but this
sprang to mind (again) while reading it.
I have been wondering if this sort of thing will lead to inconsistency.=20
Reports sometimes report more than one issue at once. Other times a
patch that is (intentionally) not a complete fix for the problem.
Using Closes: in those cases is not really true, as it does not close
the report.
Having a series of N patches, each of which purport to close an issue,
also doesn't seem quite right.
The word Closes has a meaning and "forcing" the use of Closes: for
reports implies meaning that may not be present.

I suppose it is true that just because documentation or checkpatch says
to do something, doesn't mean that you **have** to do it but I don't
want to be the one on the Rx side of a rant...


--sMLH2/sMXXEvCsA+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCaxKgAKCRB4tDGHoIJi
0tXzAQDYkO5GAuTFyz0Dvwf4L1NEyHqz2c9/ib0AqzTqT2eJDAD+LHrHwO6Glr7O
3EOtr+9fzQGH1+jlQnxnBRaF2dYZjQE=
=47sB
-----END PGP SIGNATURE-----

--sMLH2/sMXXEvCsA+--
