Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF707B
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 16:40:00 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id k23so16216808ejd.3
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=BcnlrpauSIu9WeG+OipgBvHN7I1o5jljdlM0g1Pxe+s=;
        b=LR5FWXwPuFzIjTUqluCySMkV4lLg2CADv9w5oG7qyM31JTn6F4PBoe3iDte99nT8JZ
         DdLNfQZJ1wxceKpurWECMLs2nLKfxt0xzryuwp72Vseb3JqCjOMT2TOrMwAkwUO6dgx0
         87xSY2neVlg8imiCeaS5MFilI2lld3DONqSxmzgb4D5KjQ2oO79WjdRpalBnXXL8VDFS
         ixJrwnnwqC0gZMlOzv+dxLCmBd27AsBHV6VXQLhlt7TIysPFEMbyokQY6lq465nC+8Sy
         NyX+Gq3co9xi/FBDRkppxboDarQ3UCfiki179OEpjl3lati+w7hZnRcfj8gNEyAKpg5b
         SqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=BcnlrpauSIu9WeG+OipgBvHN7I1o5jljdlM0g1Pxe+s=;
        b=gq/ltYRhT52kq1X/ojTxMrWbWJpSVwTRSST8JCgeIxhrQuSglbWGiixgWtPVY6rqMs
         yu6VP8TittSqaexsBxv3IvIrT6tYwGdQfcp9V/sTccxxe6xq7icdwXEA2lssst0axiWz
         d/J3lsMj6YJAQYAQ7RIIJEu6I3SQkGMgAlrAy/yWZ+VnkzcgoYizY6V6CcT+hOA2X2R1
         5q1uRJjW8RahvH884QL6sZkI7jDzE5acNys+5gBkEvUm85e4ncNvKXsHtSad7fXu6Vfm
         PixPWQ6G8AiaUEtd0FJeVSjlGdZNPyFCqKQMW6N6iWNovjNvjrlD20Zqych+K0kPH5ZP
         msPg==
X-Gm-Message-State: AOAM533mHoyS5q8Js01SeLPbiM1Ukv31sMsnbvbKRKG8cFXLJKflj3Zk
	8DVOqqGDHSw5BmZWP5Pnq1N3TkgCBpWrFBYZ
X-Google-Smtp-Source: ABdhPJyoLkSthTIE+SFM6nyW65QSz0VYoS25bJsyZEmD9iPVdMOy6H5mTqYXAGdSJjxtSTu6cTvHOg==
X-Received: by 2002:a17:906:dc8a:b0:6e0:94bf:1ec3 with SMTP id cs10-20020a170906dc8a00b006e094bf1ec3mr6622915ejc.447.1650040798906;
        Fri, 15 Apr 2022 09:39:58 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8ba4:ab5d:8b2a:caa? ([2a02:578:8593:1200:8ba4:ab5d:8b2a:caa])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7dbcb000000b004232ce8656fsm234725edt.86.2022.04.15.09.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 09:39:58 -0700 (PDT)
Message-ID: <b1e2ec21-bf74-06f7-2732-bd4e66d659b7@tessares.net>
Date: Fri, 15 Apr 2022 18:39:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: mptcp: add more offered MIBs counter.: Build Failure
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <43cbe1db36c118468bc6e88ced16079d05f30643.1650034062.git.pabeni@redhat.com>
 <84e8d6d6-8006-88a8-f69b-d6584cce34de@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <84e8d6d6-8006-88a8-f69b-d6584cce34de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 15/04/2022 17:10, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/43cbe1db36c118468bc6e88ced16079d05f30643.1650034062.git.pabeni@redhat.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2173091628

Please ignore this, that was introduced by a patch I recently applied in
our tree. The issue has just been fixed:

https://patchwork.kernel.org/project/mptcp/patch/20220415162801.1675860-1-matthieu.baerts@tessares.net/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
