Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8F70
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 08:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627287110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8+S7VO3Nnm1Uyon5m8hHd/54ZxZeCLrs/6uqdIPfOs=;
	b=OIfOrTxD1PbO3YazlPHg+9Aw/vs8CK/CAIOeSy/ekG8FAH/juBPNulj4geSEluehPxEKHH
	7VncNupDMEyMEmzItxnjnywmNXTwx7aZy55pIxFpsLxNZb+w2py4H3WXrFxGwtAwewj7Fv
	MzibWjvOzmv7rjGKNx9YzIZtoYbZDKs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-oRJHnUSYMQueOzXbm8klxA-1; Mon, 26 Jul 2021 04:11:45 -0400
X-MC-Unique: oRJHnUSYMQueOzXbm8klxA-1
Received: by mail-wr1-f69.google.com with SMTP id s22-20020adf97960000b02901535eae4100so2454285wrb.14
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 01:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=j8+S7VO3Nnm1Uyon5m8hHd/54ZxZeCLrs/6uqdIPfOs=;
        b=Qgh50s9hLBvg5ocy3MSlag1vUqQxdEon7TFwj/0sUKjI/FV94cqKLsIf/EwORs3bN7
         iLJ7acZ9ImR3LjdRWglC6/8fFL69ScgyiOhMfApBKjvMcrsBjB3pUNEXS7luUg1Kd9Wp
         AMLcpEZULEzf+g0993y+0Hld8Yq4/ZU7mqUK+uyIG13tqICvm2gRFQ1ncE9mi3zkKt2D
         3eRZ853UDl/0ocIvr26s0AfuTJZDRzZjem/0wmQdsSapTrILSJDa4P2LkM4w+Yyroh/L
         CnouxEkWtn+QexFAOjnUCK3PoKXPDQUwpHj0MEjobLOUstmqETmoNyP1HSVZwzx/U8PT
         8AsA==
X-Gm-Message-State: AOAM5335kqdX6jnC9LXkMpWhDyvTIQC+iAD347em3fu6rau1oHnK1SHg
	aQRThMJ61Pz+0ytk/QPa4TcM6KnAbiSwN5nU26es+V1bDYY2tYWjWOW53XaO2VSggSKETcfrFO6
	VjQSbhup5uyum9ws=
X-Received: by 2002:adf:ce82:: with SMTP id r2mr18161459wrn.161.1627287104553;
        Mon, 26 Jul 2021 01:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmPM4IWTs1x9SqhlhBpkclfjUrvvxzGkDbMV1DX11nP35pTuXsQ5vwsWiq0hJIa1TQ//Lgbw==
X-Received: by 2002:adf:ce82:: with SMTP id r2mr18161444wrn.161.1627287104428;
        Mon, 26 Jul 2021 01:11:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id a8sm8530851wmj.8.2021.07.26.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:11:44 -0700 (PDT)
Message-ID: <e0dc580be2c9b8c2cc69af25ccd5bf9600cade85.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next] Squash to "Squash-to: mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Mon, 26 Jul 2021 10:11:43 +0200
In-Reply-To: <ba5a3eff994cf1adf069c0e708adcea0d90daedb.1627222024.git.geliangtang@xiaomi.com>
References: <ba5a3eff994cf1adf069c0e708adcea0d90daedb.1627222024.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Sun, 2021-07-25 at 22:18 +0800, Geliang Tang wrote:
> Paolo's patch (Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR option
> according pm.add_signal") reverts back to a single 'addr' field in
> struct mptcp_addr_info.
> 
> Then no need to change the argument of mptcp_pm_add_addr_signal to
> mptcp_out_options and no need to modify the code in mptcp_write_options
> now, the original code is fine.
> 
> So this patch reverts back more code.
> 
> And the commit log needs to be updated:
> 
> '''
> According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
> the ADD_ADDR/ADD_ADDR_ECHO option.
> 
> In mptcp_pm_add_addr_signal(), use opts->addr to save the announced
> ADD_ADDR or ADD_ADDR_ECHO address.
> '''
> 
> v2:
> - rename the 'saddr' argument of mptcp_pm_add_addr_signal to 'addr'.

Oops, I did not notice that datail! Good catch!

LGTM (again :)

/P

