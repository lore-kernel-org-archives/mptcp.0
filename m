Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7E2DEA93
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951674; cv=none; b=PkJbrL3rxhOMxuwmIIzKbT3/zTt1gDUGUb4c3r3QA9EaOxT2CHpWek/kcwi0TWyeNxgTMedU8VBPXVD6jAfXuwjLK8ssU2l/3V6eq3uEmXxO49pRS/PBNg1JvcdNGT7fBG/ws3P5x65+us0DI1iy5UDBUE/a6ktgZYIOZ0HEAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951674; c=relaxed/simple;
	bh=Di6zLyjW4X2c7MCC8NF1iV8REhETE9iAPVp6145lobI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrhKby0VHFGxfuvN54gpllA4k3X74R8hfi/KR2yrQCvvY+eAcAx84/IiQ6gNt7cPx7HA7wGiGWcfcspLILM4OgoCijC2QjfCJ9AdAEzaLJjvwiq6zF95bISZGmZr/w5HEBxhBoqtZXocFX4XkiQMm2KnffPFlP0OErlFc4j2+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1U9LEDr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1U9LEDr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786951671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrVofAtgfUfixx+BbKkuuBQzK0gr154ob0BQ1R4yIIE=;
	b=b1U9LEDr/zS8vikl0dp91hO51qF93Vle5+vJaOpI+gmQQxwrdPiq2CWPoB5r7fU/ZIgPZa
	90b4vR4Dkcr0TjotaNqe/8FVpGoG0EfMG17/hhCVCjFAVZ16Jt9K5qqc0YIAWwmCvihk4I
	rpn0v63BLZszGP1n+hLZCTMAQSwM0f4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-t8ZHpECyOMqaazsos63xzw-1; Mon, 17 Aug 2026 03:27:49 -0400
X-MC-Unique: t8ZHpECyOMqaazsos63xzw-1
X-Mimecast-MFC-AGG-ID: t8ZHpECyOMqaazsos63xzw_1786951668
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49955a9dbcdso19648995e9.1
        for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786951668; x=1787556468;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yrVofAtgfUfixx+BbKkuuBQzK0gr154ob0BQ1R4yIIE=;
        b=hXU/MjcJTySR5zBLHVLeAo/IJieguNFa+cvHaeV0c5CDvW40CbNaJorEgCXvO2NGit
         +7HMUOEt5XZtvGrBGoBowdeiWx/JDJoQmEmcM5L36ujOeixEm8z1ZC8xFQsOz5mCvYtp
         CTLlZgxdfPWqZdbqIs743mWjIg2nlfUu645zTBXoATBSvqIt8UVsiyLd9Pt6CkJB+sC8
         I461AB6hgoc/jVIKDqdVsjcYWEe/LXgjbYVTTwq6n9uIeLL8+87ify6aA9/kL14HtM/H
         nGtY5eHzu9EA1ZmCiQ5ywwdVY5OW7Aa2/Ys/VNJ4uzNdX/qE22/3EvPxKSVHYz/R24mK
         T+hA==
X-Forwarded-Encrypted: i=1; AHgh+RqIEB9HQhbxkdaLP8HiDlZ7muYAA0CXQlXno1UWPmLlpTd6ipxp/AC/MHzbYn/hGBsKQqDt/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0DNkD+d0xgIcwwsAYsPFko2S7P3mfMI0YwZAizMgM1DklUR3R
	b717Gt9Iedi5e6BHcFMtakiWkW9QtURBHCd6fhTyPI8XN9pkirzM4r95IsoThIMdiMI2iXOn5xo
	WwsaPrrPOsDlMvMJrnMsqIgRo6ZEGpX8encJ7IdpBpwc0svWCLMXRG/rF
X-Gm-Gg: AR+sD10wb7AMs+wj4u49A30ubGnhAcfwklBzs5waYwPsYOGQHH1oK2eLLIb4aiVEvNe
	r53l7ijgyXlnjUwWXpUWC4jG6NIjz7JMYX20GUwcMHQz7zz9ir7HJzfncg0Yw1zcrEdRwI76hYA
	AmIFmyeEFqDoz/IBhIzOdLOVIgxqXP7yw1r75vy0hgSDUcH3Xbb6Bh2KGUxZmMKSaZ3ctAyroVn
	dNQ/m5N/KpsHrbzl9sNSfgFz+y0WO89BHNLjNei2ST2H2YNyhlYwkiO3ziwm43mN8x36XFa3x1S
	TIhAbWdmH0xzNrV8sPF8YgdPBWQ3JvTlxRj/u1lZBegUWV5WYzYAc2qkZY1hjyZE8y6ZtMSUZuE
	lJlPFAEtTcX8uTNZ0j5o9ZdUV4oKOh5OJ+rpJO9+sZiz56HnZ5546f3yfmkml2v6WcYqQFgirpM
	w=
X-Received: by 2002:a05:600c:a45:b0:499:5b04:6920 with SMTP id 5b1f17b1804b1-49987990f37mr330583535e9.16.1786951668426;
        Mon, 17 Aug 2026 00:27:48 -0700 (PDT)
X-Received: by 2002:a05:600c:a45:b0:499:5b04:6920 with SMTP id 5b1f17b1804b1-49987990f37mr330582935e9.16.1786951668024;
        Mon, 17 Aug 2026 00:27:48 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499877d7974sm177410715e9.1.2026.08.17.00.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 00:27:46 -0700 (PDT)
Message-ID: <e277308e-87b5-4c1c-b976-ff73cf4286a1@redhat.com>
Date: Mon, 17 Aug 2026 09:27:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next RFC 2/3] mptcp: reject MP_JOIN earlier
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-2-3ca3260f9474@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260814-mptcp-reset-mpj-early-v1-2-3ca3260f9474@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ezjEdMgmP7DqO1d_WCHNrFZndnl5J0ObC6ubv7ZMVUo_1786951668
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 8:31 PM, Matthieu Baerts (NGI0) wrote:
> @@ -91,12 +92,22 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
>  	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
>  	if (!msk) {
>  		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
> +		*reason = MPTCP_RST_EMPTCP;
> +		return NULL;
> +	}
> +
> +	/* Stop it early if the subflow cannot be accepted */
> +	if (!mptcp_can_accept_new_subflow(msk)) {

Side note: the above is inherently racy, the consistency safeguard is
given by the fallback check at finish_join time.

Minor nit: I'm not sure this check belongs here or in
subflow_check_req(). The latter option would avoid the additional
argument and possibly produce a smaller diff (and smaller code).

/P

