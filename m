Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE42F2A
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651510733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEvdQFkdulgmK53cHCl3vBoN+ADNRZ28gKNj5zrN24M=;
	b=P5n4aHXyQM+RsY8ROhdRD5ujyNtCI4hLnwoHkOROSXfyH5cTe6ErX5xW1jMMn7oB5uToOq
	HFLucW7E2o9b/xT8x2vmTtEew4eXDhuBbgDb1mFgGg6ue2bt6ZFaIIPVxBNBxvgrOv4cC0
	oxQN8q+GBN0PLxsUc9HiQ8v325EiWQw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-i1jDXilGNG6YDPgzbbkR7w-1; Mon, 02 May 2022 12:58:52 -0400
X-MC-Unique: i1jDXilGNG6YDPgzbbkR7w-1
Received: by mail-wm1-f69.google.com with SMTP id q128-20020a1c4386000000b003942fe15835so1959410wma.6
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 09:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HEvdQFkdulgmK53cHCl3vBoN+ADNRZ28gKNj5zrN24M=;
        b=E4LSifvx8sW9c7N21o/fT1C0AcmJ3nGTVvmS0YM6auTucxRmWTFbpng7oJ7zfuITzp
         Mi6H26va23yIoRr+j4Aj6LYyRSUkkGil5etQcVHZ+BrL5WQokHZzf9x5pywyOlwZKNR8
         357PQKMBwgpjhKIvnmMGCIR9SPGiilEayTDBAt2b9SGIl4WKgPlmhfAj46CvSqvnPotH
         wKHEMyoe7NWI/UAcJpQ/+SGn8nyTSBiesLSj7azS8X8L6L9b3FhtesjKKJNRiWLoqYeZ
         M2cRKsVDrLJgTyU/Fvjr5ceBuwtpWE2XyRq8Cq4BkWF9S+p30A+U/DDZnvc7CWb2zkzm
         bJ1A==
X-Gm-Message-State: AOAM531o+dCRHAAQadZnsmV458lYQVPTtk0Z/BwBbvJ+Hd1jjvQ/RFiz
	vjTXrc/zDxAzq+2AX8qRV8IEshM/Fntl9vWKkhBbi7/rjHE8Ni9kpxoQQLxhBAQJGd0hFHJJw2j
	f5lTWkDTw650MDvk=
X-Received: by 2002:a05:6000:1a8d:b0:20c:68ed:7449 with SMTP id f13-20020a0560001a8d00b0020c68ed7449mr2784736wry.124.1651510730573;
        Mon, 02 May 2022 09:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT2n7565UcwsJN89T1RmEr2LqDiF87ceeSQHupSZQbdkEM+kmAzTzgTk5PbQcUSCHnqcZspw==
X-Received: by 2002:a05:6000:1a8d:b0:20c:68ed:7449 with SMTP id f13-20020a0560001a8d00b0020c68ed7449mr2784723wry.124.1651510730336;
        Mon, 02 May 2022 09:58:50 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id d2-20020adf9b82000000b0020c5253d929sm9050291wrc.117.2022.05.02.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:58:49 -0700 (PDT)
Message-ID: <6c76401699605448e5f74859c71a147d86820e8f.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2] net/sched: act_pedit: really ensure the
 skb is writable
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Mon, 02 May 2022 18:58:48 +0200
In-Reply-To: <CA+WQbwsTJ5n94RMDi8UyMx-Y8JeBmK8jpUsi2H=Y9R5zGghHKg@mail.gmail.com>
References: <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
	 <7c93496c-5153-5b83-48a9-6dd75da42542@linux.intel.com>
	 <12a4ac76eddf80868bd61dcadfcb972d597ba629.camel@redhat.com>
	 <CA+WQbwsTJ5n94RMDi8UyMx-Y8JeBmK8jpUsi2H=Y9R5zGghHKg@mail.gmail.com>
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

On Mon, 2022-05-02 at 23:52 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> Thank you so much for this patch. It fixed the issue that bothered me
> for a long time. With this change, it seems the bad data in the
> MP_FAIL multiple subflows test case has been dropped correctly now:
> 
> > sudo ./mptcp_join.sh -F
> Created /tmp/tmp.lqIytszwoM (size 1 KB) containing data sent by client
> Created /tmp/tmp.zChji3JlEJ (size 1 KB) containing data sent by server
> Created /tmp/tmp.iTuFZCucnH (size 128 KB) containing data sent by client
> Created /tmp/tmp.YTN6JELVhq (size 128 KB) containing data sent by server
> file received by server has inverted byte at 169
> 001 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                                             sum[ ok ]
> - csum  [ ok ]
>                                                             ftx[ ok ]
> - failrx[ ok ]
>                                                             rtx[ ok ]
> - rstrx [ ok ]
>                                                             itx[ ok ]
> - infirx[ ok ]
>                                                             ftx[ ok ]
> - failrx[ ok ] invert
> Created /tmp/tmp.iTuFZCucnH (size 1024 KB) containing data sent by client
> Created /tmp/tmp.YTN6JELVhq (size 1024 KB) containing data sent by server
> 002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
> 
> sum[ ok ] - csum  [ ok ]
> 
> ftx[ ok ] - failrx[ ok ]
> 
> rtx[ ok ] - rstrx [ ok ]
> 
> itx[ ok ] - infirx[ ok ]
> 
> No inverted byte is received in the MP_FAIL MP_RST test.
> 
> Do I understand this correctly?

The issues was/is really a TC/act_pedit one. That action modifies the
packet data even when the packet is shared (cloned). Any retransmission
(or reinjection) of such packet are thus corrupted.

The test failed due to a reinjection on of the corrupted packet on the
supposedly-non-corrupting link. 

Not sure if the above clarifies the scenario ;)

> Anyway, please add my tested-by tag for this patch:
> 
> Tested-by: Geliang Tang <geliang.tang@suse.com>
> 
Thanks!

Paolo

