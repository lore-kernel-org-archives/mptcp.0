Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FE12CA1
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643716724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L20RIPWQ73vOBwtyfdBwRBFsZaqsa2/A7wOqjkTp/yA=;
	b=YkqyeOCqAVaRi0pFSwvz0d5Dk+E6WE6nENY3JDmU6VYqNusGMJM/bkIwA/tmm1kHV/DIy2
	hb/FLUxoYf8vFmnmm6D/Ye+tOuxNrw9WybtDYl7TIfTEnEJlZMWNDrlrP/GfHiGr4woHD+
	tAeAPWDXZygVdqvdAtbsk4wpeHhfCpE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-VlPR4_G8PAuNwjyYZd06_A-1; Tue, 01 Feb 2022 06:58:43 -0500
X-MC-Unique: VlPR4_G8PAuNwjyYZd06_A-1
Received: by mail-wr1-f71.google.com with SMTP id t14-20020adfa2ce000000b001e1ad2deb3dso789976wra.0
        for <mptcp@lists.linux.dev>; Tue, 01 Feb 2022 03:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L20RIPWQ73vOBwtyfdBwRBFsZaqsa2/A7wOqjkTp/yA=;
        b=rxElJcajlHodOK+YSoW51tMvxMos4i4bXU91N6QKNs7eF2kpehUK+h/vNbq45f+Le3
         NW5nrO4dzlfuxc1dLjKUIgZHtOMC471VlLaZC3fIVCsjWkOd9q2fe1tv3UkKRunjA0nR
         S0UKSe5sflVGagl55GE2rQHERUHlwQn8hWnFq5xvUsecE0J/8L55duiMg3YWcS9MPX/N
         nRxc2Fgb4NBDmGNEeU37n3YJgIiEx70EZ4o0gHh2VB5QQoGz5McpvyarX5nd0z0OKY+l
         PZiCazbgbR0EkNa0GaINktlxsaCbRGA0gdlWSw+7qM7Wzn5tQzvFOs1E/Rl7XrA4OrMi
         DvNw==
X-Gm-Message-State: AOAM531Db7NjeFtCUPRRzVAG50c0nYmt03P1Hc78Of0eG2LUock0sZOp
	KEb1B/9sfejvIeskObcmmW6zexVdRXx8E41XgYBJ2BkpH1Ueu/Y4+xmRhTSovcIgLtTIRzkJLcz
	8MTLfyXD4w8S6vDM=
X-Received: by 2002:a1c:f210:: with SMTP id s16mr1485217wmc.121.1643716722383;
        Tue, 01 Feb 2022 03:58:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqzcHrrG8kzdAOdFu3vkfpK0p8IDnDGavhGXcgZthu1seNv4IqraMIOGm0jnW+GGeEBKaqPA==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr1485208wmc.121.1643716722190;
        Tue, 01 Feb 2022 03:58:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id z3sm2312353wmp.42.2022.02.01.03.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 03:58:41 -0800 (PST)
Message-ID: <7f767e0572a9897d461e5b3cb1546811b024bd18.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3 03/14] mptcp: handle local addrs announced
 by userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Tue, 01 Feb 2022 12:58:40 +0100
In-Reply-To: <20220128003836.2732694-4-kishen.maloor@intel.com>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
	 <20220128003836.2732694-4-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Thu, 2022-01-27 at 19:38 -0500, Kishen Maloor wrote:
> This change adds a new internal function to store/retrieve local
> addrs announced by userspace PM implementations to/from its kernel
> context. The function captures the requirements of three scenarios:
> 1) ADD_ADDR announcements (which require that a local id be
> provided), 2) retrieving the local id associated with an address,
> also where one may need to be assigned, and 3) reissuance of
> ADD_ADDRs when there's a successful match of addr/id.
> 
> The list of all stored local addr entries is held under the
> MPTCP sock structure. This list, if not released by the REMOVE_ADDR
> flow is freed while the sock is destructed.
> 
> Additionally, this function enforces the kernel imposed limit on
> the number of local addresses that may be used over a connection.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v3: incorporate the new sysctl configurable limit on the # of local
> addresses that may be populated by userspace PMs

I think here we could use omem instead and avoid introducing another -
possibly hard to configure properly - sysctl.

/P

