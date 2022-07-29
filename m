Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED704A24
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659111005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TA9cb7ugqlhNOUMjqH4abfcGp/S6VYvvZQRWc7mn020=;
	b=So1zAfSHBYgCAZH+E23SOe77krInk06or+bPbfDtt/+LSD0v/7Aa7Az+TxKxnt4CKKCekO
	H5gebrr6BTy1VzLUjxyZPaPfkEMMLQbpuWZZRk9r9UNO2mucDqiRrS+8UmqD9tfhh50KYN
	GN/dB0SqoSKTQbMKc6L+ZjH8kjjzUq8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-ktdkZfK0NduAxETGTFpubA-1; Fri, 29 Jul 2022 12:10:03 -0400
X-MC-Unique: ktdkZfK0NduAxETGTFpubA-1
Received: by mail-qk1-f200.google.com with SMTP id ay35-20020a05620a17a300b006b5d9646d31so3876871qkb.6
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 09:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TA9cb7ugqlhNOUMjqH4abfcGp/S6VYvvZQRWc7mn020=;
        b=Upj0ixHKsjpf5VudLsGDGUT6IHff8g7SoXo7ui7kE/zM9/yG2Yfm3IaTGawVR9vysS
         WhX7Ffd2ZG7pQZd44wn7I6K7URcXjm9T612qg7QYowMeUljwJf+fNZNpFno0QL9xAY5w
         6xQuUTKBA0P6PoYzsLJeVIdnB7nVD0Q4obVXB7gTGQa3aTeFhJd/0HYouGbG5egy2IDF
         ULse50UB+0155+37YBqcE3KruAYmwO11IXVUFW4vCGfJepjnZ/KJNQROqDf6WPsZzWzM
         UAQ5JiS3Rb94iK/sdFfd/eCXLioq/O1una4SM8S1eZlHOO6ciBJ9h2TaT4ZJmHfsv/2X
         jeHA==
X-Gm-Message-State: AJIora/Lfl3SH0n6YGGZOhLPukhQs5xDqDFMGt1fS8GVVRR0MrB/a+PL
	MwnJGT5dHeLobeVZuC8sv/p87QushnpXv3tQOmsoIU1yBw5lkBHAuiStu/B4a/ohVz7MirJXH49
	FpOmstSp+UcjhR2Mm0/nL22CTYTwiQsTTTWDz5Z2BtQWjKSyCxAF2McWRDoX3+mFp
X-Received: by 2002:a05:620a:2710:b0:6b5:bf24:10e9 with SMTP id b16-20020a05620a271000b006b5bf2410e9mr3282370qkp.28.1659111002606;
        Fri, 29 Jul 2022 09:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syM9+Z0D59Pr8cXs9qOUzhmDlXYiTmDStMvI4zBGet/fKEfQOTvysGzHCVwkrXNA1tIZs/Ag==
X-Received: by 2002:a05:620a:2710:b0:6b5:bf24:10e9 with SMTP id b16-20020a05620a271000b006b5bf2410e9mr3282340qkp.28.1659111002223;
        Fri, 29 Jul 2022 09:10:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-164.dyn.eolo.it. [146.241.104.164])
        by smtp.gmail.com with ESMTPSA id t4-20020ac85304000000b0031ee2080c73sm2375180qtn.54.2022.07.29.09.10.00
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 09:10:01 -0700 (PDT)
Message-ID: <8b1f82abc720de4d75bae6ea0324f255d834d4e4.camel@redhat.com>
Subject: Re: mptcp: use common helper for rmem memory accounting: Build
 Failure
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 29 Jul 2022 18:09:58 +0200
In-Reply-To: <c42ea753-9808-f3c8-fa7f-ee4fb5055f10@gmail.com>
References: <f253e24227ce660aae19714c2cca1726ee087184.1659107989.git.pabeni@redhat.com>
	 <c42ea753-9808-f3c8-fa7f-ee4fb5055f10@gmail.com>
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

On Fri, 2022-07-29 at 15:47 +0000, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/f253e24227ce660aae19714c2cca1726ee087184.1659107989.git.pabeni@redhat.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2761676692
> 
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1f45050af065
> 
> Feel free to reply to this email if you cannot access logs, if you need
> some support to fix the error, if this doesn't seem to be caused by your
> modifications or if the error is a false positive one.
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (Tessares)

Darn me! some latest local change did not land into this series, I'll
submit a v2 soon. Sorry for the noise...

/P

