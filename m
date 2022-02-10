Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86142F21
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644489382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEklPHjwVbdOPQPWTcXXuyvJGHa+aQrmam/AgufdBdE=;
	b=VPeWdK8LE2v28C6zI4oljHgvAUlQohN/QEtTotworMHWaDs2U39Zw04mcjlRpx6PNf4i63
	11ef7QxQOq2pHCUqKUuLSKHugH1EmLG2Fa1rB1LZgcO7IRxf81qDc+2qonA4y+6GuexfYp
	WMuUfOsgjKr5GZg9Xna4qDJewn0Td3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-cLR-q-7hOfu6qIrprDsVgw-1; Thu, 10 Feb 2022 05:36:21 -0500
X-MC-Unique: cLR-q-7hOfu6qIrprDsVgw-1
Received: by mail-wm1-f72.google.com with SMTP id r16-20020a05600c2c5000b0037bb20c50b8so1334548wmg.3
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 02:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wEklPHjwVbdOPQPWTcXXuyvJGHa+aQrmam/AgufdBdE=;
        b=1725drIiFikqRUraq3sXWfaE9VmxU+LrkfVqpHagMH6PHQBNqddkLNfQaYWvtNIpvW
         BL+7IIA3QpjUyxEqDx1nYsLpLTWelDjWIGbQLssLzwPb+HcqpTFVnkIRQSQwjtmBN3cV
         ILWUmwJzdnukSl/oMy+5swKtgv4OV7LYsRdJWNxVLVRgb96+JQMGE+/oi9Mpg6IlXo7K
         zmVKztKaYTiGAChE3ggUJQxUR8WI0fyYFiQvIVmRmFOEnmuxsTtujrSSyKxsFP01OxWx
         xfxUkRuaDXbHSuf/7vqwH/6nl4uz5/b0xr3QDQ9LvDSjorXzCEcgH+56Hgu+P3VOZue6
         xMnA==
X-Gm-Message-State: AOAM533OgF6rYy2rpDxlmWVQS+A/3u/P0sNGzqcBM/pcY5oWld8GKZb9
	oPi6aJWAWcs/Rqlc4srcxsW8kXGzAIo7M0I55I4b6NN04pNwZoXAR3NPIhQnxuipLEfft1plpwk
	+H/4sTNkjU/fasEDBSVWyflvu55efCROZToqctNpSOp5hpJRv/a6ePZpP80hwofK0
X-Received: by 2002:adf:c74f:: with SMTP id b15mr5965144wrh.307.1644489380206;
        Thu, 10 Feb 2022 02:36:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhf1E45HlrSiKZ21fFYw+TYHX4qCI7T5gww3XGPxy6BOLJnCeFBRrKgB1Jub0JznYEQPqq6A==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr5965125wrh.307.1644489379987;
        Thu, 10 Feb 2022 02:36:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id ay38sm1660847wmb.3.2022.02.10.02.36.19
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:36:19 -0800 (PST)
Message-ID: <47e854cf68fdc2a1e0b2c9e79813d4212393faac.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] mptcp: strict local address ID selection.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Thu, 10 Feb 2022 11:36:18 +0100
In-Reply-To: <75e02d63aa8b03b873ad94f5b4d901776f9a81ea.1644487551.git.pabeni@redhat.com>
References: <75e02d63aa8b03b873ad94f5b4d901776f9a81ea.1644487551.git.pabeni@redhat.com>
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

On Thu, 2022-02-10 at 11:07 +0100, Paolo Abeni wrote:
> The address ID selection for MPJ subflows created in response
> to incoming ADD_ADDR option is currently unreliable: it happens
> at MPJ socket creation time, when the local address could be
> unknown.
> 
> Additionally, if the no local endpoint is available for the local
> address, a new dummy endpoint is created, confusing the user-land.
> 
> This change refactor the code to move the address ID seleciton inside
> the rebuild_header() helper, when the local address eventually
> selected by the route lookup is finally known. If the address used
> is not mapped by any endpoint - and thus can't be advertised/removed
> pick the id 0 instead of allocate a new endpoint.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: send v2 to address the build issue, to help the discussion

It looks like I was too hasty and this is badly broken. Please ignore,
I'll try to cook something better later.

/P

