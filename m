Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FF22CA0
	for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1640079938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDdPmI+EDeFFV/q0mgmcp2MZ0ZDT0jyI3Q1Wh+i4BuY=;
	b=h2mfNu9Sa6pwFyCptaTOqbPjnj4E/F4zTm6P11B+aVJQ9oSONmf0G+tZCpb1TQDvP4HLDa
	KWZ94sSYqL8SY6bsF45Dwr78aJCMqfPF2ZWr23JTLVvRvaSWeGWw7Bj2ZrXQVWNE61LqlY
	TrMX+4b8hh6mpmP5tcR74mWRHNk9xu4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-4xP7YYMxMCSZLUdEaJMjFA-1; Tue, 21 Dec 2021 04:45:37 -0500
X-MC-Unique: 4xP7YYMxMCSZLUdEaJMjFA-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so1028547wma.3
        for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 01:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MDdPmI+EDeFFV/q0mgmcp2MZ0ZDT0jyI3Q1Wh+i4BuY=;
        b=GnEzG1AtAx37uWxkCAKpj1lKPZsjWnm84xnJ9VlQSsagH25mp0+hNUnOAxBKbCG9fs
         ViSA79CjjiSDH84DTVshqd6eV5d4Ev+UsjUiX9qCwu6jT+zONvg0ApusQIfaIcmdeXfY
         uweGFtGoc/QJe7IMVUn1ODqxo8yCw+IUbauxHHC6r8bgWu3t9SjhkyTJtnP9aCBUdrlj
         dW/I1kEiDqrSJx9C7azPXuJTtHKwL9BtzHghbSLAZ4KjMhl8JlfA9IBM7HPbCio3ltnL
         mfi6TS53oYJWJvD289YrBKqppTpqmlIA6+l/JYP+i54SNfjJPuusrjB2XZcO/VFNg15K
         pahg==
X-Gm-Message-State: AOAM533ECLNPHa1EB3TQewIKwV+JowjjiKmZWo65bkkLjcS5kjNWiCXU
	wgnWlZai585gS+HoqVby1dOacW8+wLTzLvuTEeBtSYfMhc61wcwUcjq73Ptasw4uHoet9Xoc+ZB
	9UphjmW2j/bzpkac=
X-Received: by 2002:a5d:6d0a:: with SMTP id e10mr1860875wrq.327.1640079935845;
        Tue, 21 Dec 2021 01:45:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ7JQnbE9Kj7mzhfg6grfEx+Z1ChceWFXBedHdyF71HGxaUHrr1skDxxz1F/+1sL085w8YXQ==
X-Received: by 2002:a5d:6d0a:: with SMTP id e10mr1860863wrq.327.1640079935600;
        Tue, 21 Dec 2021 01:45:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-225-60.dyn.eolo.it. [146.241.225.60])
        by smtp.gmail.com with ESMTPSA id r1sm10880031wrz.30.2021.12.21.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:45:35 -0800 (PST)
Message-ID: <0c44a4f2371ca515edce8ba67f60778f9c990cb9.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 07/21] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 21 Dec 2021 10:45:34 +0100
In-Reply-To: <c84d9c47-0ef8-4e00-3724-b6e323c0bba4@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
	 <20211216222314.1244708-8-kishen.maloor@intel.com>
	 <e9dd7944-6eb5-b96e-4192-d52c98decffc@tessares.net>
	 <c84d9c47-0ef8-4e00-3724-b6e323c0bba4@intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-12-20 at 23:32 -0800, Kishen Maloor wrote:
> On 12/17/21 8:29 AM, Matthieu Baerts wrote:
> > Hi Kishen,
> > 
> > On 16/12/2021 23:23, Kishen Maloor wrote:
> > > This change updates mptcp_pm_nl_create_listen_socket() to create
> > > listening sockets bound to IPv6 addresses (where IPv6 is supported).
> > 
> > Should we consider this as a bug?
> 
> We could I suppose, at least for lack of completeness. But you're right that we've
> now updated the behavior in this series in attempting to create listening sockets (lsks)
> corresponding to every announcement, which necessitates this handling of
> IPv6 addresses. 
> 
> But prior to this series: 
> -lsk creation (through a subflow's port) did not happen in the kernel under the assumption
> that MPTCP server applications would've established a listener,
> -lsks were created only for port-based endpoints which (I believe) would not work with
> IPv6 (lack of option space), and,
> -the stack did not allow incoming MP_JOINs at machines running MPTCP client 
> applications (with this series, subflows can be established from either end so there
> needs to be an lsk).

Could you please elaborate more this last point? If the stack does not
allow the latter, it's definitely a bug. The port-based endpoint
implementation was aimed [also] at that goal.

Thanks!

Paolo

