Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670812F26
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 09:38:26 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id y3so29666355ejf.2
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 01:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=fV0uL3K1f//JRQF6FVSmtCzngKSIZZ/dmOKvpjszyjQ=;
        b=oNd7QvcNmL9s550ISwNXwIqwbhllNzhwbLEggchEsCN4eKu8gmxHBTn/NpJsUoNwJA
         izvJmlYK4Xkbn1Qi8N4q0OUM+vGpRIdMEdkWB1iepAleXtRkjWeFwSaujBswCOepqMMF
         mabf8xt0zTkClxpPjMLcWQFKUP6oA8iEkFvbMalsBWgg5S6lkx9iSUSz2zFN37U18z24
         IdSDZEDCxQeluA+8gxHQUYiH63xlDbbclnHhpPOxL31fMogf3foc/aeVKbUzfU7c6iLL
         xm/eChwr8MuGGwbonjqMHsZ7bC3XtAV25zFSfAA6KWXaGKzSa6no+/FoWPebwYS6ntL8
         dq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fV0uL3K1f//JRQF6FVSmtCzngKSIZZ/dmOKvpjszyjQ=;
        b=xRf4w66887LpZhPKs3CSE0FZs8ALr7c/56f7xJ06JGIWfgRhf2N+Spm491BbL905rX
         o3ph55/n6/y3zwKYrYRESyRQVuSxsAeSm/7B6ZUuY8JxoraQgh2o3XazNBtnEwnxerhD
         hado7zkfGo3xLW0n9JocgylakasrkPuhuuI0RRFaqfC/N40Xy8atPtR+qpYp9oF7fDGN
         mePRh9Fjyvq4RE3QeW0/mb39Yo9Z1rmH77n7G91Ns3reENtpkxQ6gDJeVTkShUWYyQan
         G600wXzy8vMFh+iLGFTO1KpEnbe9FXqWMUZgu2agxeU5ntvPKjwvuHPeEzPhsQxAKbKg
         M4Vw==
X-Gm-Message-State: AOAM5314EETX9SQ6CBUE/poL+Dv4NOVpQl2gfm2lSWRBJZn6qtd9BExl
	KJVZeB4LdGAczoTH15l2XRPXEw==
X-Google-Smtp-Source: ABdhPJw+T/mKEOQNwIGVw6yxuDcKGUJt73wnZlCG6biRFcF2grjAg/bAk6xRce8YgG+D60ovrL41/A==
X-Received: by 2002:a17:907:6088:: with SMTP id ht8mr2776838ejc.619.1644313104524;
        Tue, 08 Feb 2022 01:38:24 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:ba0f:5a93:d93e:ce85? ([2a02:578:8593:1200:ba0f:5a93:d93e:ce85])
        by smtp.gmail.com with ESMTPSA id y2sm3979014edt.54.2022.02.08.01.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:38:24 -0800 (PST)
Message-ID: <c3205d30-822a-b124-f474-b72bd1588476@tessares.net>
Date: Tue, 8 Feb 2022 10:38:23 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: adjust output alignment for
 more tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <9ecd5de1df130bc1d5cc65de7c940ea546cf4eaf.1644214533.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9ecd5de1df130bc1d5cc65de7c940ea546cf4eaf.1644214533.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 07/02/2022 07:16, Geliang Tang wrote:
> The number of self tests in mptcp_join.sh will soon be more than 100, the
> output alignment is no longer OK. This patch adjusted it.

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

- 14b3f02f7484: selftests: mptcp: adjust output alignment for more tests
- Results: ce83a4acc66a..f092cd7abb9f

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220208T093806
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
