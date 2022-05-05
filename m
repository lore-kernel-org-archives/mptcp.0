Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762DC623
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651751407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i67tjVaHB78cF63WCGFJ3CI1nO+ngKMIoetrGgmJHsE=;
	b=V1hPzsD/jysvk4A0+nwNEQq26G3nhHKHG045vABEkWDexxrd4o9VZivz5NG4GqPP46KfyX
	R2Aeva4W7GhaVE2H4rK8L7BaY+pdd4XNxmDdkjZBjo5Dh9fRb+J+S20u0Qa7R+EZk8KFeE
	VBDaa5ueF2Vp6y3Yn+jFQBQ5R5qk7P4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-kw2ngYSMOgecoiz1Nb0DFw-1; Thu, 05 May 2022 07:50:06 -0400
X-MC-Unique: kw2ngYSMOgecoiz1Nb0DFw-1
Received: by mail-qt1-f200.google.com with SMTP id x5-20020a05622a000500b002f37cb8b803so3125838qtw.9
        for <mptcp@lists.linux.dev>; Thu, 05 May 2022 04:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=i67tjVaHB78cF63WCGFJ3CI1nO+ngKMIoetrGgmJHsE=;
        b=E8noGu+m5TbSrSh+hGjoK5h7DuTFXnObU2NtGDe6aTzEu7XO3ombHwle4NvrPUKGOe
         9nhQDdRP3bj+Q+Tc/kldv6k8AFIXF1Y1odI9etamPpo72Fssq+c8jCp2IMGd9zo+KdP8
         ZYbOEwb4hjbLm783JwfePZsge3vQe3u4IzrGoHlLGSs77v3/aYt1eDnWnC/l3NuoMUfw
         4hr5ydokZH7M+ZDnsbdr0nnaiuyuIY1+7cm0Kv9mDwI9M7Lj3WqaMc5GLRfNYw3vhkDc
         M34L3MYE+ADQ5GwgdkUhfV0Gc3jTGWIkAMPimtOG/E0hS0VilISeut+e/Mg7LkOobwg8
         /vuA==
X-Gm-Message-State: AOAM530lQkq38YuHZlEhxTbtGFcNOAWv51sq+sPNohx+r6tt+hyWdvfK
	15ZpRiGWznypu4ZpQd2+umtXIynxXTezqN6kBWHBKtb4MqavZbnSLZwxb5YkdOqfDa9KQjzm1QP
	8NIqAy8Ab99GZlWU=
X-Received: by 2002:a05:622a:c6:b0:2f3:bc21:6618 with SMTP id p6-20020a05622a00c600b002f3bc216618mr2180834qtw.581.1651751405823;
        Thu, 05 May 2022 04:50:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOTBe3w3XwO/LTDfuNLb9fUejFkDt19134p1Vhe3E4XGpHcM00tYTmOmxXiDwwWATyL/GdXw==
X-Received: by 2002:a05:622a:c6:b0:2f3:bc21:6618 with SMTP id p6-20020a05622a00c600b002f3bc216618mr2180819qtw.581.1651751405564;
        Thu, 05 May 2022 04:50:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a270a00b0069fc13ce202sm656175qkp.51.2022.05.05.04.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:50:05 -0700 (PDT)
Message-ID: <0606e0fede42a16c93231498d23c9afd5c05e26e.camel@redhat.com>
Subject: Re: [PATCH net-next] mptcp: fix deadlock in mptcp_close()
From: Paolo Abeni <pabeni@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>, Geliang Tang <geliang.tang@suse.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	kernel-janitors@vger.kernel.org
Date: Thu, 05 May 2022 13:50:01 +0200
In-Reply-To: <YnOu5xlGgE2Ln7lj@kili>
References: <YnOu5xlGgE2Ln7lj@kili>
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

On Thu, 2022-05-05 at 14:03 +0300, Dan Carpenter wrote:
> The mptcp_data_lock/unlock(sk) functions are taking the same spin lock
> as the lock_sock()/release_sock() functions.  So we're already holding
> the lock at this point and taking it again will lead to a deadlock.

Note that lock_sock() (and release_sock()) releases the relevant
spinlock before completion. AFAICs the above deadlock is not possible.

Still I think we can revert commit 4293248c6704, I don't see why we
need the addtional spin lock ?!? 

Thanks!

Paolo

