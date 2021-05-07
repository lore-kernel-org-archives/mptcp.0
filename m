Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1572
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 08:07:09 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id s20so6741823ejr.9
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sJeEExCsN8EDu8a93RgvFObLI1zSbViCQUNAdxpbMoc=;
        b=Wqt2mw5dBmhCowt9spg7mMHUqtCIe28u7i5khM8G+BMH13cEu9AEJJ/nPswZx8npZR
         89F77kFUzVCQEQxiaM3HnghFn070NcJAMQyi+EakjB9MgtMLOlJMUXZEphw+o/ytcJ3o
         2tD4hFmIm88P76RL7h3xTlS9D2PYnZX6gkm2fDGVpj7ZnugqjoSCafltFtGUHHCbskoR
         Va8f9Zgf17AL1+3UIoDexiAMJ4Nmw6zgo+YMFOnwi64CmXFI1rkx6Bo4vk+Pu1DMqGtV
         NRLdoS2zEnf69W964KUvHkOthOZwhI0xks7fPABGzIiu7VMcU76oWAf111ATDNDQyIdr
         xoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sJeEExCsN8EDu8a93RgvFObLI1zSbViCQUNAdxpbMoc=;
        b=uM44H2q+Xh8ouuTOr5RrBSV1PPTvlCFavsDcpckQhZ+eSEvyKy63relYCgtoe90vRS
         rGT+3988vT7nuGkv/7K3yN2s4fraau3z3Wq0vw7DwMYEhqJVMf7+BhG9uaffhbBD7nIF
         oErA3aJ8s4RrPo4/ixxZlzx8AfA79QUmy18mreQ9thm+yd7VPQ1LjCoTB4Uek+bE3DXe
         pdD5vzw+7mgaQpTgR2huFyO/oFCKTSE4dPQhp/YyTeCRqpOFucidOdalF6JoKAgqPMnM
         C7X0RMQriDU+A0a1GLvrwTOK+hNpABfbhCO03xDa8zDNNgRgiLF/L9XWU1OZDmS93l3A
         FU7g==
X-Gm-Message-State: AOAM5308QhoR+zctbqIUohP/VKkxc8VBGNQ3O7Djqsea80UkJTuhhwpM
	KYS8RTze2L+crWZ/6ZdAUkObdkTk8C424d864LFYnA==
X-Google-Smtp-Source: ABdhPJxQv39fRYfeju+fEzGzDTk47sogp4/NOvs4CvwgoF+7aBN9Y1JVidzUSDRL2KJn3s3TNqbYCQ==
X-Received: by 2002:a17:906:8904:: with SMTP id fr4mr8834658ejc.146.1620374827483;
        Fri, 07 May 2021 01:07:07 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([109.201.130.16])
        by smtp.gmail.com with ESMTPSA id r17sm3501985edo.48.2021.05.07.01.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 01:07:07 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 mptcp-next 2/5] Squash to "mptcp: add the mib
 for data checksum"
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <cover.1620286893.git.geliangtang@gmail.com>
 <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com>
 <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com>
 <CA+WQbwvjyRF+hpcOfFJoaam8+X1y_eF9N3JQSA6hvbfbMQdp_g@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <9729719d-6331-89d0-5bdb-3bd7f24c41bb@tessares.net>
Date: Fri, 7 May 2021 10:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwvjyRF+hpcOfFJoaam8+X1y_eF9N3JQSA6hvbfbMQdp_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 07/05/2021 04:50, Geliang Tang wrote:
> Hi Matt,
> 
> Geliang Tang <geliangtang@gmail.com> 于2021年5月6日周四 下午3:48写道：
>>
>> Rename DSSCSUM to DATACSUM.
>>
>> Please update the commit log too:
>>
>> '''
>> This patch added the mib for the data checksum, MPTCP_MIB_DATACSUMERR.
>> '''
>>
> 
> Thanks for apply this patch to the export branch, please update the commit
> log too:
> 
> MPTCP_MIB_DSSCSUMERR -> MPTCP_MIB_DATACSUMERR

Thank you for the reminder.

Indeed, I missed this one!

Fixed now (but not yet in the export branch)

- a1c71b9ff8ec: tg:msg: MIB has been renamed
- Results: 3ad3c4cba5ea..37818f5e301f

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
