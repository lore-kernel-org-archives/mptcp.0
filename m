Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098D846A
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667577457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XY84A8aXXKFGyJpYlggkZzJ31bZdfjRAu2/+8RBpxbo=;
	b=Ysrvs1lnq+hv9pFhWHGrUG6SEGYsYQ+GCQv2wzE6YuRSeM2wVXdcEcPW3ZsgZcrUa5Y4uv
	sD273iFgJsUZQKwsv84SAWWSDyLXoPgg3B0sTITjTwhZobBoMR4nSogZ6ACoIoeH6j91t5
	bwyrcnmdsBFPG5B3zEHXlj7YOPM5Cwc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-529-vNIhdacMNgWI0vorcwKISA-1; Fri, 04 Nov 2022 11:57:35 -0400
X-MC-Unique: vNIhdacMNgWI0vorcwKISA-1
Received: by mail-wr1-f69.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso1365376wra.1
        for <mptcp@lists.linux.dev>; Fri, 04 Nov 2022 08:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XY84A8aXXKFGyJpYlggkZzJ31bZdfjRAu2/+8RBpxbo=;
        b=1j0zda13jFH+cql8r/XnS2WvV3Moe7JPLtZsRAFHBySHEz7s7NzXgl0z/Mm7D31gBG
         Ee0Qfy3l24jrDHl0jM4VRb/6zmXlunuT0o9pK7IyxE3kUT0q1tkvAZp0+zg+FGJqZuCb
         2+x5jDbR4m1ToILDuDiQArF7tYSkoLkPAC53xh44H+sBOFL6Gijkce8YQPb4F+dappZT
         8mxJHFYGU08o4ujwcTeeXo/ttsP36dnM1MAq3y+GYhuvRTB+emkVGc1BBT/dCqiTC9D0
         BrAwQXH7SnC688khmx5HBdjVOZUH+zAq4XZaMAnbKv/A7RGSu4QYDjvnWZLvfT1RXSyK
         3Sqw==
X-Gm-Message-State: ACrzQf10D5pHFI8dqvIhDSoCwHpBkW2r8BWkNxWycz1X9mpNe5DrKnvs
	tap8OAzCdJ0eoCPpVJgfi1Fz0gmR7yFV6pubx9Ky9DLPBg1DYEEpXWws4m9/R14f5KUrLxB3kTr
	NWFieUzd8Jogp14o=
X-Received: by 2002:a05:600c:4f53:b0:3ce:6cf5:e1e9 with SMTP id m19-20020a05600c4f5300b003ce6cf5e1e9mr33321068wmq.107.1667577454331;
        Fri, 04 Nov 2022 08:57:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7LKlAu12gXTRpl/nhXTTftZ7jhjm1vQFytjB/dq5aF0WLLxQl8e+B1xtY1kYmnCk70gzYtYg==
X-Received: by 2002:a05:600c:4f53:b0:3ce:6cf5:e1e9 with SMTP id m19-20020a05600c4f5300b003ce6cf5e1e9mr33321053wmq.107.1667577454114;
        Fri, 04 Nov 2022 08:57:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-124-216.dyn.eolo.it. [146.241.124.216])
        by smtp.gmail.com with ESMTPSA id by13-20020a056000098d00b002383edcde09sm3856976wrb.59.2022.11.04.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:57:33 -0700 (PDT)
Message-ID: <0c139c30ad0d626a67ddcffb83c83e211471c542.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: use entry->lsk directly
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 04 Nov 2022 16:57:32 +0100
In-Reply-To: <20221104115354.3413-1-geliang.tang@suse.com>
References: <20221104115354.3413-1-geliang.tang@suse.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Fri, 2022-11-04 at 19:53 +0800, Geliang Tang wrote:
> entry->lsk should be used as the PM listening socket directly in
> mptcp_pm_nl_create_listen_socket(), not the initial subflow socket.
> 
> This patch fixes this, use entry->lsk directly instead of ssock.
> 
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Sorry for the late review. I also don't understand exactly what bug is
fixed here. Could you please elaborate more - even in this thread,
before an eventual next version?

AFAICS, this patch introduces a functional change: before the msk
created by the NL PM was left in TCP_CLOSE status, while the tcp
subflow entered into the TCP_LISTENER mode.

After this patch even the msk status is updated to TCP_LISTENER, which
is possibly cleaner, and looks safe, but I don't see a bug fixed
here?!?

Cheers,

Paolo




