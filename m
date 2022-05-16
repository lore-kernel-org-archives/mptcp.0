Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DFE10E0
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 16:22:27 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id f2so14234118wrc.0
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zTTFTQKwdvTMIYTmtHWNFRAJr3WfWhNujNC5AV+Xb0Y=;
        b=Ilczs8t5m29I4my+SHt0lFeo4IEQfJGymY0BnKLbN4N2jAHH2J9EX8vax2KXXlN2h0
         Sz9QxWucEgvkI7l0eYvnYxDsLW1Ej1kykHwPzfxltkPmsa56v1tq3goTb4RcQh1zBKDM
         dYTdCKW/P5yDLqAfUsyBVOvGFCUxdo8Ms0x7aFLaayHhKRYthbsw08E2R83IEqPBzVlM
         tXRDWSOr52FM8CsVK7zmJZ12o9b/wz1D49bZnvxHIKUvCAQ7EbmGgvAsm8RmhTVT0q1b
         G9uJ4mrL0VPiJISGXY5S8yH8XpYtBRcTvh7L3R61/4VeupcssYiJiVpNZaFfyF0tLX1E
         TmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zTTFTQKwdvTMIYTmtHWNFRAJr3WfWhNujNC5AV+Xb0Y=;
        b=5chUwJkq7BPnnPH1WqZ3y/4eMm39D/LgW4+depsZn2yx1bsWSoEz3tsgntIY4ETnZK
         0/JE+SWGs12230wlL9gfNXSIKKuSNWYJsyNFGbRk+cO4SbVnNclVYHhcLJ87hX5eq16o
         3dzvZ5/45Q11sJ9gCKJgsXvtKnm+lPZRvTY1fAoiyTMrTaxRYlFPP4KVJuPAkLVgYGuC
         6HCL19GXR+Yp2F0eaf19HjuXJExrO1esgJnDpf6kG8tp8A8MvTf1Ke0er9dcZTwyDJFr
         2wdeGAoZhoRFedf2kUiPlM4CQQhRE2Djpy8HPHWHrXv/KSdQ98NAz5+b2SgGbUOvu4dn
         Pr+g==
X-Gm-Message-State: AOAM531Pn9+vUfw/3EL2bG90bgUD8lCd8OF7IJOUx47KXWnaIoMW+f9h
	AjDfySJ0ZBeEZJjc9u7BVWNgKw==
X-Google-Smtp-Source: ABdhPJzUPT9Yga0ELY7Cw/JbER2stsPEd1Fw+Xx2uSwAna/tQ7rCgpNSbSxcAjkLeBSJwT49I6dYlg==
X-Received: by 2002:a05:6000:1569:b0:20c:4ed4:4ba8 with SMTP id 9-20020a056000156900b0020c4ed44ba8mr14483429wrz.270.1652718145480;
        Mon, 16 May 2022 09:22:25 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d10-20020adfa40a000000b0020c5253d8fesm10292848wra.74.2022.05.16.09.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 09:22:24 -0700 (PDT)
Message-ID: <31ceb1cd-75ca-afdf-1fd8-668928421cad@tessares.net>
Date: Mon, 16 May 2022 18:22:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next v2] mptcp: Do not traverse the subflow
 connection list without lock
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20220513003521.548193-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220513003521.548193-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 13/05/2022 02:35, Mat Martineau wrote:
> The MPTCP socket's conn_list (list of subflows) requires the socket lock
> to access. The MP_FAIL timeout code added such an access, where it would
> check the list of subflows both in timer context and (later) in workqueue
> context where the socket lock is held.
> 
> Rather than check the list twice, remove the check in the timeout
> handler and only depend on the check in the workqueue. Also remove the
> MPTCP_FAIL_NO_RESPONSE flag, since mptcp_mp_fail_no_response() has
> insignificant overhead and can be checked on each worker run.

Thank you for the patchs and the reviews!

Now in our tree (fixes for net-next) with Paolo's RvB tag:

New patches for t/upstream:

- 032e9e845d39: mptcp: Check for orphaned subflow before handling
MP_FAIL timer

- 8df40881ecfe: mptcp: Do not traverse the subflow connection list
without lock

- Results: 7e5581f27ee6..cd3c57373965 (export)

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220516T162107

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
