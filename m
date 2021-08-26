Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390872
	for <mptcp@lists.linux.dev>; Thu, 26 Aug 2021 18:24:39 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id n11so5996617edv.11
        for <mptcp@lists.linux.dev>; Thu, 26 Aug 2021 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8vt07/l7JpvXNHABIsE6H5sQnlPJumb9Pf+eU5SuTvQ=;
        b=rMNqAfBoUiddvVFhWSX9K1EzyOs2/dIpaZ6/uvymEr2xa78lcOUjvsqzZZKlCytMKo
         GNLMEUOUROW+CrpD6+I+5eh/kef0llXqaK/zK2jaQxuGbLvNNAUptm9TCO9Ru3KvWQK8
         /LZl17oQ4l42q1dc86mHJpQ68S+OYpCjLmyk0pXPWQ70IiUiq0W/6cObQwM1eimIZ7sS
         PviJU1bgD02vnuEE3gFzkpwvRC0bu+GsBx4Qnd3Qc4haGF2O7lDRbLInuAnZdvRbALdu
         /GirloShh5tH5d7BD1RG5iA2O+R2M26u9islU7q6xp6vnWwURfZnA851IQXRfKEMScM4
         Rn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8vt07/l7JpvXNHABIsE6H5sQnlPJumb9Pf+eU5SuTvQ=;
        b=mmv4a5k5rcKt6Bva6UlGyXNZlVxej2iikYkgwWAowyszK/sJPBq/0KyBNzOQojZfUZ
         XEky8zUYlsaRzMJdHAPqa6B+D3vMu/wA5wR9dkvypj57SOJhI7gudn/heWKdKKSEgynw
         ogbUU/jdMC86JJfAXCZISC7kez4DFM97vEmuL3HxwEcwWBrWnWM4VcJtvy2D8lvbQWdO
         IyDfjYdMqbxcduMxLiMMlIxH2w0exuoB4pi25H8y7cr67MN46dltbSit2p0kWESdz4IF
         53xZH8pFQoqe40rIPZgkfwoGGYxtrhr5EGAJ3DtfDJW/DM8qYi1QAUua0KdjmpUUAUw7
         xs3g==
X-Gm-Message-State: AOAM532AVEP8rI94vNmLWVlafVD1bGDpYxZM2b0II7rb5n0/Np6fFT3E
	cErFwR8xVCP+wM3FXy5K0+bFmu2z4UnSP/bG
X-Google-Smtp-Source: ABdhPJznJVt27yZwzMfiEVc2emS+Vd1JaLtdii0rukSezhJvGOecjKNweC8/fpeJ6rftBI6yR8zvNQ==
X-Received: by 2002:a50:d088:: with SMTP id v8mr5636881edd.387.1630002277786;
        Thu, 26 Aug 2021 11:24:37 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id di15sm647398edb.20.2021.08.26.11.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:24:37 -0700 (PDT)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, pabeni@redhat.com
Cc: geliangtang@gmail.com, mptcp@lists.linux.dev
References: <20210826004601.196834-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net] mptcp: Only send extra TCP acks in eligible
 socket states
Message-ID: <5ea0f310-8798-e436-24ae-2476b16b1813@tessares.net>
Date: Thu, 26 Aug 2021 20:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210826004601.196834-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat, Paolo,

On 26/08/2021 02:46, Mat Martineau wrote:
> Recent changes exposed a bug where specifically-timed requests to the
> path manager netlink API could trigger a divide-by-zero in
> __tcp_select_window(), as syzkaller does:

(...)

Thank you for the patch, the review and the testing!

This is now in our tree:

- ea8a43942429: mptcp: Only send extra TCP acks in eligible socket states
- Results: 99a16463048d..6d52100ab2ab

> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/229
> Co-developed-by: Paolo Abeni <pabeni@redhat.com>

Checkpatch is yelling at me because a SoB is not present here.

@Paolo: sorry to ask this question but for the record, is it OK for you
if I add it? :)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210826T182120
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210826T182120

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
