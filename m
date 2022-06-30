Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01396D19
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656605895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNPVhG6FFRFuQ8eChNznVvTx8ZpBlO1Hc/5puE7Ig94=;
	b=WoqKMp4V5NzvQlJKaj5VSNmJWs3lxMrHGXdZs+9jtwPNjXjfmJI9XfyYGouUeHkoPpxELi
	wcHPFbbw+++W+nVWexqNA6NUfjX31ZHWL6wpddmC+S77j8pI6/ijKKHRTWQ/h9wqC0dU+V
	2jZeNqo09XGfh7LUxhUDSJhxbnP2gFc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-sNaZZldtOJ61usrJ8fyZhA-1; Thu, 30 Jun 2022 12:18:13 -0400
X-MC-Unique: sNaZZldtOJ61usrJ8fyZhA-1
Received: by mail-wr1-f69.google.com with SMTP id l9-20020adfa389000000b0021b8b489336so3258615wrb.13
        for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 09:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TNPVhG6FFRFuQ8eChNznVvTx8ZpBlO1Hc/5puE7Ig94=;
        b=zQLqMnCNtSRDaPwtIdqexY7A5O3+tUp+06RqfpoeiJEBaJOptjmdBBDWf+1giyWK4D
         n/Y+/uFb2aYXgBl4+SQivfWwFL43+aAaB67sSVYOP2mHmrfK81Sm5E+DvpulwXxfnNRu
         1k82pPPz9uZOCs+48DHLtNEuvgahAihpKi2yTiJR9jFtp1fAI/ub+Ff0tWABFyqWaPuD
         XpXt7LDbg4llOs8jdU0e/n731Kq8y+A1bOLaw9mOmo9cVHMdQPLu9m4hm3qG3bvs2YSZ
         88C/y5/mXYgftGG/3PBhfyl8Z21X21vh8rmJZZ9fFotXvmjuqtEb828e0Xm6u02NMU/r
         mlmQ==
X-Gm-Message-State: AJIora8rt40Xcl4VMEsYoTtzL+ZRktuReqh3GXTowqYJrxK0BOkr9GqI
	+nxl9y9ReRaOOIKGicL/z08g7Csjx6xjpa5lru1TVbrdRXWmH0m/0LvD9UXvH3HwkgY6juM08i5
	h2MVvOaqk7+1O7bs=
X-Received: by 2002:a05:6000:1844:b0:21b:b06f:a3a1 with SMTP id c4-20020a056000184400b0021bb06fa3a1mr9724367wri.357.1656605891833;
        Thu, 30 Jun 2022 09:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tK52NYS+6yOJcW/39vVPJNTUd0kFqCdV2md3T3rl2VApvTs5f+PMel3AFxu2wwY8zD6V2NTQ==
X-Received: by 2002:a05:6000:1844:b0:21b:b06f:a3a1 with SMTP id c4-20020a056000184400b0021bb06fa3a1mr9724347wri.357.1656605891601;
        Thu, 30 Jun 2022 09:18:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003a0502c620dsm3056102wmq.44.2022.06.30.09.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 09:18:10 -0700 (PDT)
Message-ID: <6bfbf8f4852f3491330c2ab8cbc2ed28920cd734.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3 0/2] Locking fixes for subflow flag changes
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Thu, 30 Jun 2022 18:18:09 +0200
In-Reply-To: <20220629225327.657202-1-mathew.j.martineau@linux.intel.com>
References: <20220629225327.657202-1-mathew.j.martineau@linux.intel.com>
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

On Wed, 2022-06-29 at 15:53 -0700, Mat Martineau wrote:
> When working with Kishen on the userspace PM, the locking code in
> mptcp_pm_nl_mp_prio_send_ack() caught my attention. The
> release-and-reacquire of the PM lock in that function was requiring the
> userspace PM code to grab that lock, even though nothing protected by
> that lock was being accessed. Patch 1 addresses this.
> 
> While investigating that issue, I realized that
> mptcp_pm_nl_mp_prio_send_ack() was not holding the subflow socket lock
> while modifying several parts of the subflow context. Patch 2 addresses
> this, and is not a drastic change since the subflow lock was being
> acquired anyway in mptcp_subflow_send_ack().
> 
> v2->v3: Fix build error
> 
> v1->v2: Based on Paolo's feedback, fix MIB issue with atomic context in
> patch 1 (tested with CONFIG_PREEMPT), and squash patches 2 & 3.
> 
> 
> Mat Martineau (2):
>   mptcp: Avoid acquiring PM lock for subflow priority changes
>   mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags
> 
>  net/mptcp/options.c    |  3 +++
>  net/mptcp/pm_netlink.c | 13 ++++++-------
>  net/mptcp/protocol.c   |  9 +++++++--
>  net/mptcp/protocol.h   |  1 +
>  4 files changed, 17 insertions(+), 9 deletions(-)

LGTM! for the series:

Acked-by: Paolo Abeni <pabeni@redhat.com>

