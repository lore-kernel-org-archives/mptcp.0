Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E567B
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661373438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5GTZD4Ze2jISn/5ZqZmcMlNM7aY/GBZIjNaPxrSz8s=;
	b=Dk88JjyxD3EwCfGtlIjb/3EHXgUk5O9l4oMeEKu+4UBdJr0/67VUUDvJGE6PK1a1wI79hT
	u1LhhNCFcfFy54nVTPEqlCfQgD/sdCNHAXKaG154haKMPzrUu2ISr0lv6lQ6m8egucH/Or
	O5GB4c7G4JRH5siNLhY6L1MzrrxDEc4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-7MiAu3fPOXS0CWReh2QbgA-1; Wed, 24 Aug 2022 16:37:17 -0400
X-MC-Unique: 7MiAu3fPOXS0CWReh2QbgA-1
Received: by mail-wm1-f70.google.com with SMTP id f18-20020a05600c4e9200b003a5f81299caso9860614wmq.7
        for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 13:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=Y5GTZD4Ze2jISn/5ZqZmcMlNM7aY/GBZIjNaPxrSz8s=;
        b=jgNrv+CJTdrzdOOMQ562FTFHZ7IhkiJqjtHEynuFIoMdk+28s0B0BrU9i7t4K9J/Hj
         y0AwIdFa5UVIBMKWc/se6XcCrwCOhsrArody6hwuoRwHzIVzAjw0BVUCkyNxo7sdpWMn
         11vwFJEl0UD6lKJiA54St9qxQhgHaxH7v/akAcK1ciB2WeY4AIKrgi7JUZ/vpQaZrWJK
         uYMuWt1DYGQbUeKq9Wzh/RT2kQMvI0gNVfcEhB1M2UgztDQhdQmn58WvBBfIKq7D5kGk
         UUc9peNsbi33cMiiVWE0aQ7ht/UEdEsMtf8yB1Oh8n9CdFhTEj8uI8YFf7AJlUw3ZsD6
         SL2w==
X-Gm-Message-State: ACgBeo2QgsuiYYt0pvDFP6NDP1MjMpxCwP0gV3cc5V6m5zw6bC+LiZ0v
	AY6A3SZ0CvYpNe+7aqy8nk10TiI1LOiLk+9k+5TsNP5uZUrpxGtiQe0hxOY4uMz7c1bO4m3ogOZ
	qansTr2YWj+DR870=
X-Received: by 2002:a05:600c:5103:b0:3a6:14a7:1a1c with SMTP id o3-20020a05600c510300b003a614a71a1cmr6405175wms.193.1661373436093;
        Wed, 24 Aug 2022 13:37:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR78Tkyo17IJvtYe7ud5WSM9tuAIllBsMGQC8Y+a/WgP5V9WHyC2TlM3ZE7yt+3N77tQV58wPw==
X-Received: by 2002:a05:600c:5103:b0:3a6:14a7:1a1c with SMTP id o3-20020a05600c510300b003a614a71a1cmr6405170wms.193.1661373435889;
        Wed, 24 Aug 2022 13:37:15 -0700 (PDT)
Received: from [192.168.129.164] ([151.82.183.45])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d564a000000b00225307f43fbsm17620640wrw.44.2022.08.24.13.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:37:15 -0700 (PDT)
Message-ID: <c359cd4e1ea2970d0bd3d3127773d08041ae2acd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: allow priviledged operations
 from user namespaces
From: Thomas Haller <thaller@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>, Paolo Abeni
	 <pabeni@redhat.com>
Date: Wed, 24 Aug 2022 22:37:14 +0200
In-Reply-To: <49976d61-c3e1-3991-37b3-4751f8a96a5c@tessares.net>
References: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com>
	 <20220810074251.31887-1-thaller@redhat.com>
	 <3af41bc6-436a-5849-b2d-9564dd8f46c7@linux.intel.com>
	 <49976d61-c3e1-3991-37b3-4751f8a96a5c@tessares.net>
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,



On Thu, 2022-08-11 at 12:34 +0200, Matthieu Baerts wrote:
> Hi Thomas, Mat, Florian,
>=20
> On 11/08/2022 01:08, Mat Martineau wrote:
> ...
>=20
> >=20
> > Thanks Thomas, looks good:
> >=20
> > Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>=20
> Thank you for the patches and the reviews!
>=20
> > [...]
>=20
>=20
> I initially thought it was more a bug-fix but I also agree with
> Florian.
> Also I see that the two mentioned commits above don't have a Fixes
> tag.
>=20
> The only exception I found and related to this flag was for l2tp: the
> commit 2abe05234f2e ("l2tp: Allow management of tunnels and session
> in
> user namespace") has been selected by davem and backported to v5.4.
>=20
> https://lore.kernel.org/stable/20200417.105100.821338189941807731.davem@d=
avemloft.net/
> (see patch 03/19)
>=20
>=20
> Anyway, your 2 patches are now in our tree (feat. for net-next) with
> Mat's RvB tag and without a typo (s/priviledged/privileged/) + a
> small
> fix for checkpatch related to how the commit are mentioned, nothing
> important:

Thank you for the adjustments, the feedback and applying!!


> New patches for t/upstream:
> - 3d542a6c45ea: mptcp: allow privileged operations from user
> namespaces
> - 11bdb1959854: mptcp: account memory allocation in
> mptcp_nl_cmd_add_addr() to user
> - Results: c4a0ae952875..004104cc8a77 (export)
>=20
>=20
> Tests are now in progress:
>=20
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220811=
T101116
>=20
>=20
> @Thomas: BTW, thank you for maintaining libnl!
> Funny that you sent these patches to MPTCP while earlier this week I
> sent the latest libnl version to Debian :)
>=20
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1016867
> https://tracker.debian.org/pkg/libnl3

Oh, that's nice. After I rather neglected libnl for quite some time, I
want do to a better job in the future. :)



On an unrelated note: upcoming NetworkManager 1.40.0 release will have
basic MPTCP support and configure endpoints. Similar to what mptcpd
does. This was the backstory for the patches.



best,
Thomas

