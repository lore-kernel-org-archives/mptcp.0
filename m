Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2EB1C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 15:33:22 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id o9-20020a05600c510900b003f17012276fso32833wms.4
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681832001; x=1684424001;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zEhyMPwbfCF+TQQiG2Dl9wPLnmo++OUmev7EpcFvEA=;
        b=t23ngu8oOmzvygkv3Y2ct8a7GXXs6ApkRIkZFkvmo1VaoImuRLrjKQETvIn7p7STJV
         HKBDer5MnzGHoyGwjt9g3GCWm5EzIXuIlPVtysuI4Jaf9tM6XjdGYK+Dm38Rr+Glh/9m
         s8qT0MVivEEMgFDzufvY+Ur4txJsqeJj3igem2tXGY76Fzfy5ffNQkyRCfzopF2JTQ5m
         ceopjdnSDVVH5Oo+8tmROgn8exd6jVtsgA54SQbmUdTNYaiqaqAxfUHTfXaO8Gks4zl+
         rA9EuRdFxgwzQWkzMkGFWeulHzyh/j3WkOQgDcGP/Kz2GCHRl9TXi2dPlLi5ajzTWApC
         sVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832001; x=1684424001;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zEhyMPwbfCF+TQQiG2Dl9wPLnmo++OUmev7EpcFvEA=;
        b=JmgKiW45RY+ZDpCKkefWnmaj4KpIIXpdWPVG2VauhbxJMxdc+01hKyb8nWlQ/erjUY
         e2eiHN6CHRoJ4VL+5HzSa5gq34E5DaM3Zf0oph5oQ7FA/TSHsFVDTv5XzjupBWbXTGDt
         7GNiEVhnigTeHDcBVX5vEHrUpVOW7yOCWMdboT652bA+CP8Dr4PL2F6dWj1qoS1YQ2KN
         BSTfCDwu1yqBVUat1jtXCL+V+79uaVcBXPMReq7KfI3Pc503u/A4S2GRukk3GRFqB/Kg
         HELnmrK32iPSsFwTtPkExgUsoQKUkBpO4TRvwUs4m4xyDv9/tHPAFvxkGFuIAJz7rBiT
         OjvQ==
X-Gm-Message-State: AAQBX9fWOLPQyboazsUFh2dO8BKCrWEqCxB0gnvUpxL6bBTsAhgD66DX
	eDSm6OTaiLCEe425KzMSYjkKRD5sH/oi/+Kr1u3//g==
X-Google-Smtp-Source: AKy350alayjp4ULqCWk4Rh/MbmjkJbb+wyurpsggFfQAwVD2RzzjfbSlVK9fPxjkG9MzXXnznZ8LaQ==
X-Received: by 2002:a1c:6a10:0:b0:3f1:7316:6f4 with SMTP id f16-20020a1c6a10000000b003f1731606f4mr5778850wmc.20.1681832000648;
        Tue, 18 Apr 2023 08:33:20 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b76:be36:72bc:27e0? ([2a02:578:8593:1200:1b76:be36:72bc:27e0])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b003f175954e71sm4944664wmq.32.2023.04.18.08.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:33:20 -0700 (PDT)
Message-ID: <66250418-5fcf-044b-cc35-b70142c5db36@tessares.net>
Date: Tue, 18 Apr 2023 17:33:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v7 2/7] mptcp: only remove addrs in
 nl_cmd_remove
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681463340.git.geliang.tang@suse.com>
 <bb500770192e1876ca353183f7f255918dc39f49.1681463340.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bb500770192e1876ca353183f7f255918dc39f49.1681463340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/04/2023 11:11, Geliang Tang wrote:
> Only remove addrs in mptcp_nl_cmd_remove(), add a new helper
> mptcp_pm_remove_addrs() to do this.

Thank you, the patch looks good to me but here as well, I think it is
important to explain the reason why you are doing that, e.g. according
to the specs, the MPTCP_CMD_REMOVE Netlink command should only send
RM_ADDRs, not deleting associated subflows.

Because it was not supposed to delete subflows, I guess you can add:

  Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")


Also, do you not need to modify the selftests because you changed the
behaviour? I guess "userspace pm add & remove address" and "userspace pm
create destroy subflow" are affected by this modification, no? (it seems
yes, when looking at patch 7/7)
Do you mind doing this modification in the same commit please? (or in a
dedicated commit after this one here explaining the link -- but maybe
clearer to do that in the same commit)


(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 990c21a97975..535c1b3ae6ed 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -845,6 +845,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>  			   bool echo);
>  int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
>  int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
> +void mptcp_pm_remove_addrs(struct mptcp_sock *msk,
> +			   struct list_head *rm_list);

Small detail: could this go to the previous line please?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
