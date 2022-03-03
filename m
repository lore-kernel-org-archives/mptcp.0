Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D17E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 14:58:20 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso5053764pjo.5
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 06:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=PZIVcycPLo+BXzmEG9lfM85+FfOMo9ESoVjjNURxJ4I=;
        b=PCOkPkB4s8ZXZqnBl/tlqO658GJifJpoE5UQMYJncXzNS7p71x1FXVj5Vlm7s957Jm
         k80ll7C6H5DpI6ms39tmxzcjFVcpkCrB5pP59QArPs47RgulA/fMbKikjvh3vPXiqdcs
         HkGywGdUyuaBjY9IL3RycIe7l2QF1vBz0PZi9jVV+I2B74U3pl93J2ysR/qC0MRxUpZp
         amF2wqpgHX9EEX9c2NBTlSK2tCxTTcjsD40ldoLWDhwLRB02YbFdd9HnzOkAHpxgHa2a
         f1pMxep/kWxhMXqIDiWOB0dphP+do3JELTK0GwAEVDRAZyVjU63eb4CpG9CRHZQe+Vfz
         sS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=PZIVcycPLo+BXzmEG9lfM85+FfOMo9ESoVjjNURxJ4I=;
        b=62Tq+ju4TD39xSgO7BWuQ+5EiLyJ5FITcMzHbTSjoJ6z2amdeXOuCBQXPqRY0vtdMF
         DGnLtz/n2nJGFa+KABFVrTANKvf8W8+l7cfstnnk4szrwZduJP+KIrSx1peCJ2vNkgyZ
         +LIv+cX9Ga4311JFhevxtTaE9hdBcJvHR5NWBvvZZuE9nP4KueqHmInIYhxFg+gXUj5x
         2msFN//uboqGKiYOdCfI6SVlEtEz16sWP4muCEdZ8JVBGxMJxFHuhESrqCo4gNwgiSSA
         WeS/kUdHphjF/bIXdLytl0i1eBh6EHR/wQzGWGGjFWzzbXd13j4NpgaeqqqcKRMgojC8
         V3IA==
X-Gm-Message-State: AOAM5312jQjOOj5aNRRvkew/eEvDGlVUxwyG5SgvELLpfYXDtNM6XpAi
	zXZ9R/Vs06ykMTVOnTZjN5xTIR745w==
X-Google-Smtp-Source: ABdhPJyphxOzDz7rH/Ev8931EekICO4taY5Fsede7WtdT+PdR3peLwlCJ483cMLCeUaav71Y4mC7hQ==
X-Received: by 2002:a17:903:192:b0:151:8df9:6cdb with SMTP id z18-20020a170903019200b001518df96cdbmr11604654plg.20.1646319499736;
        Thu, 03 Mar 2022 06:58:19 -0800 (PST)
Received: from [127.0.0.1] ([40.86.178.184])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00190500b004f104b5350fsm2972977pfi.93.2022.03.03.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 06:58:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ad07af14b07078bf3162924a5c3ab69198fa68c8.1646318613.git.geliang.tang@suse.com>
References:
 <ad07af14b07078bf3162924a5c3ab69198fa68c8.1646318613.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: exercise bpf_mptcp_sock(): Build Failure
Message-ID: <c4c6195a-4328-9e39-de74-524d11881038@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Mar 2022 14:58:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/ad07af14b07078bf3162924a5c3ab69198fa68c8.1646318613=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/1928674211

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e17812e4ee=
5a

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
