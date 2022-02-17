Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F151FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645135119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5G2oRNSal2FlAgc/dJjRR1yx08+1hZr1+BwrBlzA/M=;
	b=jPtZkXgTDJEwk7xjeoZF8ASpRImrU5gJqTKJH+L4f6OPHKpW4/CBOgcEiAAicNGIlqvs8H
	HbvNYUtz2WRZNCO9FyE6LAVYY8DvPH0/wgKkCZnnRGFfQC5tHwsxFxu93urHaaMdPaWMhS
	tgbOuXsNgG7Lj0N/odb99gSi3Ige3j0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-O5R2du-fPUmactax86CV_A-1; Thu, 17 Feb 2022 16:58:38 -0500
X-MC-Unique: O5R2du-fPUmactax86CV_A-1
Received: by mail-wr1-f70.google.com with SMTP id w26-20020adf8bda000000b001e33dbc525cso2841105wra.18
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 13:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=b5G2oRNSal2FlAgc/dJjRR1yx08+1hZr1+BwrBlzA/M=;
        b=ncSBtQbHf0/fjMUITNSWiMLhxwVEkvG754ySlS/W7FHGpjDM641UTLvUqp0hO0x8MQ
         nBjbzsmtNik4/h2e0Jt6vAPZHfAn6fcL3qs//kKcZR1T36FAfhH7EBGJ+FAt4xseOHuJ
         IJet240cyjxtMj0RVtzccwa6eOxKdg7nazenCp6Do0XYR0BoRtwIRjMC/5rxt/yMEv77
         F9XkC21hVmd9b8UhJCuU238wLcvNPXPYnOOi4qnShAOUPpO9sNHkMDuUjU77HeN3mMbU
         yceW4bl+N2Dn8cZJttkiMQdpjqiQYyeGa+sMET0zAsyCAq33cgGIajdafIFDtSL8aq5n
         5mBA==
X-Gm-Message-State: AOAM531+OjQDGOMUVEQoekL6Kf9Nfc4XlKDY6BrlxXT/JqwbKX8/rLLd
	YwisFH6Ef+oGE/NtS9Pn6BATE+WJjZu3aW2lcDxmEh9XPiZhawk5jSm5msqtexIfUM1ikoK5bmx
	TBWJ9yiQNY3AKp+g=
X-Received: by 2002:a05:6000:1103:b0:1e6:2787:cdf4 with SMTP id z3-20020a056000110300b001e62787cdf4mr3764771wrw.31.1645135117163;
        Thu, 17 Feb 2022 13:58:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwf/UululmxhLv6FKDtIYMPT2wICvczvLgD02Qukll6uLNEC9iHb60dzHSVwsHK6QE4ZwMSqg==
X-Received: by 2002:a05:6000:1103:b0:1e6:2787:cdf4 with SMTP id z3-20020a056000110300b001e62787cdf4mr3764762wrw.31.1645135116936;
        Thu, 17 Feb 2022 13:58:36 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id z17sm2297115wml.38.2022.02.17.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 13:58:36 -0800 (PST)
Message-ID: <f99582a630cdb54490462277f06dfaac204e9f86.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 3/5] tcp: add mptcp join demultiplex hooks
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Thu, 17 Feb 2022 22:58:35 +0100
In-Reply-To: <20220217142538.7849-4-fw@strlen.de>
References: <20220217142538.7849-1-fw@strlen.de>
	 <20220217142538.7849-4-fw@strlen.de>
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

On Thu, 2022-02-17 at 15:25 +0100, Florian Westphal wrote:
> Split from the next patch to make core tcp changes more obvious:
> add a dummy function that gets called after tcp socket demux came up
> empty.
> 
> This will be used by mptcp to check if a tcp syn contains an mptcp
> join option with a valid token (connection id).
> 
> If so, a hidden pernet mptcp listener socket is returned and packet
> resumes normally.
> 
> This patch series does not cover timewait sockets so far.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Following-up todays mtg discussion WRT filtering incoming MPJ on
existing endpoint. 

If I read correctly, subflow_syn_recv_sock() will filter the incoming
packets vs the annonced list, but only if the incoming packet's
destination port is different from the listener port.

- incoming request targeting a bad address and/or port will reach the
syn-ack before being rejected.

- incoming request targeting port 0 will likely be always accepted.

What about moving the anno_list check in __mptcp_handle_join()? Should
address the 2 above points and keep the anno_list traversals to the
bare minimum.

WDYT?

Cheers,

Paolo

