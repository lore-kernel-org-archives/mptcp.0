Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5840B6C3
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738903; cv=none; b=GNCjJhoIGABE/SedjmRycZ5vWP/GnSxIKIw3f1zoNgDxhqrBuTXJTIYg6cziss1rTF5pW7ohl0Lk7ha0kgQ+uepIwiOuTSHLzunlHCZhhps56hD88yv6T5YTKqVatKaiFkrknTPw5bWz1u2hcalia/pEeSxbNaVNLfpAq/LUnVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738903; c=relaxed/simple;
	bh=V+ip7hOaNxQN+PupY79i45O/+JJVNlH3/T229lk4eXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRxtgIf6OVFP1TtPP9T9m329HKkJEqZYVOuQVfa0XROmNn5kopPiw5Wfw+5nkdEdOf0b/3GTvDlLfSx36CfDW2X0/EWam3EKbdUcECsyLFDA1MWicGksgK7iPS3chmHFGVOA0961vhzKVmHusa20fOHrJLqWzPW002GxmFs/xd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAO0MwtB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAO0MwtB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782738901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxtVeyiP7HimsNveV07yo+ZQVotxy5gp97RrKjEG4ko=;
	b=DAO0MwtBetxvn7P8gyekpyeQb4uhAfqt13YP4SdxlT3FGacqjo8s42oleXEBuISpHAW/TI
	751K0VpZHq7HdaoUrHXqPGbZa+h639O5eHVXYiZoBrrc4tagtswN5YBsBuj1RlYsK6ZMMO
	T0bfzZw7g7nRiyztWQ0RHNqrEUPh/5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-ciLBOz7IN56uy-zYTSbLeA-1; Mon, 29 Jun 2026 09:14:59 -0400
X-MC-Unique: ciLBOz7IN56uy-zYTSbLeA-1
X-Mimecast-MFC-AGG-ID: ciLBOz7IN56uy-zYTSbLeA_1782738899
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493b786d550so9225e9.0
        for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 06:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738898; x=1783343698;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxtVeyiP7HimsNveV07yo+ZQVotxy5gp97RrKjEG4ko=;
        b=TkNte+jz29WmhO6dFew4Zl3u4dYfD7zqODf/9r2OpmCn65S6qnE8LMjBiVTFjipH96
         WfKNteQwG4SxAUnGrt7utTRJkQXJnViiSbq7SJRA3dvOcNELlK1IfX7Ezs+LQTFf1uLb
         nQY8K+Y4lT2G/f2bjORFU6NQWDablew/rPaQYvrbDu9vF18oBGzdrqFg24XGksuHEcrX
         LYogrrElu3KYD8EIBGxeMp1rQw6zAwS0QOVLYJFwGphHsHtBNtDTnnug2tf6y/AIj1TG
         JOKqwb5bW6ALsAvtJ2uUQ9G83K5W3ctlFqSgx0YwElJco+Kb4qY/LL01Z5ZdLjKS8e0L
         fGpg==
X-Forwarded-Encrypted: i=1; AFNElJ+dopMIojmeRYotWUPSnHkdeU2cWJ1oMKa+/ilB2mqnFS2pf0iBibLsXnO0ogMVhZueWWW49Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTnkCPKF19M7v19qkIDtNbwdMP8tpzOSapX6IBpUDd83RdFbsh
	EeieImU/I7BerC3w7rEu1c+v4N5gZjl8yFNGr4ZwmsUaHQEfA9ES/OgDtotQdUXn/pn/309DDet
	qFQqQ6bw9+bcYrT5Kj9DTwPqi/3YWLgeh8C5+tKFszAQfuqwFCZkPJCKK
X-Gm-Gg: AfdE7ckLevpFrokYK/wEgoxufI0bQwbM0I4V8aYRNHmAnIoKEgVMiHfYyEN7OPQkPm3
	8czDZqvp1ykxEDSeNNA1kaHoFJnjsFnlKuVdaOtMWKL7TkbYIfzZ+HxoFMJbsEsSpttQ84+bU8n
	luDUK71g7SGvN81ceGvj+Tgp6tg5qjQGYEM0E6OZJbczjrcZSeEDVvA4O7ZYTDRDgHJlE0iwnJl
	q/whA9PYXVZWRJ/itzFK4lv6TM1Nb/KxV5czP6BDnSSw7x5p0na3SJRGfm/S0phdGa8FMqDCVVC
	Y3kjOt+lFx84yvUApFJxews/PYrrL1UOqxOHu+iGRwhePLItOKVpTgB8CG58/se6psyDvolZQaM
	DZFb01gT6NlfQs51zwZy+pGMa7FBD5bp40E5ktLYLpOe9OPFv7/W/Hz5Ae3KaoSLIG1P46PvlFh
	FVpK9/R/PvZw==
X-Received: by 2002:a05:600c:34c1:b0:493:a61a:a3bb with SMTP id 5b1f17b1804b1-493a61aa533mr85901685e9.22.1782738898547;
        Mon, 29 Jun 2026 06:14:58 -0700 (PDT)
X-Received: by 2002:a05:600c:34c1:b0:493:a61a:a3bb with SMTP id 5b1f17b1804b1-493a61aa533mr85901235e9.22.1782738898043;
        Mon, 29 Jun 2026 06:14:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c278ab2sm182095195e9.1.2026.06.29.06.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 06:14:57 -0700 (PDT)
Message-ID: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
Date: Mon, 29 Jun 2026 15:14:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping is
 present
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260617215725.1116295-1-michael.bommarito@gmail.com>
 <3ad5bba8-18b9-48a6-94e0-99d958f23984@redhat.com>
 <CAJJ9bXw4Xz=Y8Jt1KxSTA-0EOfKU829zGF7nJcfwWPQjh4ZGyg@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAJJ9bXw4Xz=Y8Jt1KxSTA-0EOfKU829zGF7nJcfwWPQjh4ZGyg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 32_l65S0pGEimih35qj_8uE7qwQbs9ADfII4sXCRjds_1782738899
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/29/26 1:00 PM, Michael Bommarito wrote:
> On Mon, Jun 29, 2026 at 5:50 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> Isn't this fixed by commit 5e939544f9d2 ("mptcp: fix uninit-value in
>> mptcp_established_options") ?
> 
> I did the reproduction ~10 days ago on linus's latest, so definitely
> still reproducing.  I think 5e939544f9d2 was on the TX side and this
> is about the RX option path, so they don't overlap on flows either.


Right.

AFAICS the RFC is a little vague about enforcing meaningful flags
combination.

I think it would be better to avoid another conditional while processing
incoming ack. Does the following solve the issue? 

Thanks!

---
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0ca60314d667..b924209a9b74 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -157,7 +157,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr++;
 
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
@@ -178,6 +177,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}
 
 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else

