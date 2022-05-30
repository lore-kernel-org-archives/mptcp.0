Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A817F8
	for <mptcp@lists.linux.dev>; Mon, 30 May 2022 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1653903008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvz7HL3YrXvridwtJCPx6romhzg7j5mTyCPHjOzz4w4=;
	b=OPoH1FEsLS9YH479339wHkyPkt0CFNzIOJL0zl2JfndeNVdWpojqD4TxZv8mabgGmcGPQ1
	Ryk+Tp67ESuUyyehck4UVOheiVLAGnjiYBySKmoYuvOMHYRJuY6QD/UlDQ28wPSz63Cf35
	5TxDZB866lSdEfMkLDbxgTyR17O5l9M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-oRg4O6HMNr2F9GanZAZC1w-1; Mon, 30 May 2022 05:30:05 -0400
X-MC-Unique: oRg4O6HMNr2F9GanZAZC1w-1
Received: by mail-qv1-f72.google.com with SMTP id dw10-20020a0562140a0a00b004644636cc8fso2520606qvb.22
        for <mptcp@lists.linux.dev>; Mon, 30 May 2022 02:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dvz7HL3YrXvridwtJCPx6romhzg7j5mTyCPHjOzz4w4=;
        b=2VpJ/sTEtA76NYMtUQmO+9osJXM67BAgPTUi/cbDvDbU/hYmhcdHPz9WeDHi94MFsR
         8nEliHFttT68mAhQnJj2v4j7k+lBpQjq74JaaBvbcBNb0lEcFQ7WD1QsQmQ91/xYEA8d
         fHT/CaeNH1eFizAWyNfvzwseXH8mjPRCDYoUB6l4CP7hQjvnq7EM/F+8krZ45f9emOqJ
         syFg8BoN6pCtNVD5CvSsjJysj/JdllcFyGmZvyOaR78jmLziT1peNwa2F17TVXT97lDP
         Y/osi6q3+Re/1gOc7c9GUWzXaIzG5zFHaj47aSBh9+1eJGzdlpfHbE62E4i/Pn4X63x6
         H61A==
X-Gm-Message-State: AOAM532K+CUg5V60YWouAE99obzxqH+YS02zwI47pnVzCQK8Hg6OaFJI
	eNM5rBoBEECyymK85IH09il6FTcAJValXxVRmzklzL1AdcjaYrDfAF7xAaE2IMvELHzmsC7fyOZ
	GzWGwEkurmRZwbl8=
X-Received: by 2002:a05:620a:4403:b0:6a5:9b36:b49e with SMTP id v3-20020a05620a440300b006a59b36b49emr17398987qkp.674.1653903005201;
        Mon, 30 May 2022 02:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9jjdcj+35zeuT54SkxbuqdJ0V/mjBnlWtRwkMY1xP0k2M2/oTjkOMIsTF38QSxeT9dooyLQ==
X-Received: by 2002:a05:620a:4403:b0:6a5:9b36:b49e with SMTP id v3-20020a05620a440300b006a59b36b49emr17398979qkp.674.1653903004878;
        Mon, 30 May 2022 02:30:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id c17-20020a05620a269100b006a37eb728cfsm7392184qkp.1.2022.05.30.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 02:30:04 -0700 (PDT)
Message-ID: <0059e366a67740ebff64ed024fa1bf4f743a7d28.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: move is_scheduled into
 mptcp_subflow_context
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 30 May 2022 11:29:59 +0200
In-Reply-To: <d0566f954ee527d31c37f118602e0c4b7d9f1654.1653790818.git.geliang.tang@suse.com>
References: <d0566f954ee527d31c37f118602e0c4b7d9f1654.1653790818.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

Hello,

On Sun, 2022-05-29 at 10:21 +0800, Geliang Tang wrote:
> This patch should be squashed into "BPF packet scheduler" v3.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

It looks like this patch should be squashed into several existing ones.
perhaps is simpler if you provied a git tree to pull the new revision
for this series ???

Thanks!

Paolo

