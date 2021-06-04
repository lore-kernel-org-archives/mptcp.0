Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D370
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 19:58:26 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id b9so16182970ejc.13
        for <mptcp@lists.linux.dev>; Fri, 04 Jun 2021 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K0EuQahp//BzQT3hRb+tk5BEZOQjz5MwNiQbNDyQxjs=;
        b=bZcGXu5Xit6xjWCbI436qWilSuF6rvrccuQ1jBwuk1rJ2hebloPmwXnzxJOqMzpW48
         EhO5RbpZr7UGaUZxt4LtZO2eJgZLCC8Ful3hW9y0Lpm9J2vETalygGPkB4RxNHoD/CQi
         x6Y2t1kBFnlJs7fsmNtS2svkOKD2pCH+7NrMtWvsJSy6lDRbeRCbjxS1upfS/4t817Zs
         nVGnBJ7OgE7i9ooHWNh+qZNW1P/VnDeqmpsyKKEuKOL+gz2ruj1o6a/I93w2sgq7W5aZ
         9a8KpD7M+fv2aBUenPuLaensjsA9a0GIG3pfOc2cxcuglOuAlGjf06N+Gn9dv+hcwkNx
         Rszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K0EuQahp//BzQT3hRb+tk5BEZOQjz5MwNiQbNDyQxjs=;
        b=Hksi1//sDiekqiOsfzbpu5XXGsyHhfplp1ywNgiJwXSmZ6t3TeJlRNouRPBF2Qqs2D
         Zxq7Ws1gObubS/obAfpACKLbDveoMIK++EG7WtQks1tPKENe+mJK3jpNIZ80uX/w8InF
         +fYqufId7QpC9uCAnhUa3eqIQymtU7DyDz+xjm2VzcgR4mjCSDymPB3KgigOJxOIkXYA
         oKsebcRPf9fSaMGok7Qn8pgsLCde9Z926/zj40iNEgkUIvM23hBK4eknveQYcJDY6JZS
         ypwxq8I0N5QcHujpGU3LcAKd8tW7cBBRKRa6CTJc+8Y2sLdJ00qy8hTbxOOvQLKoPuRH
         ubFg==
X-Gm-Message-State: AOAM533sym8rMAYu9krWIcPXbKJk7Kn1TcNuo4lI/JexKz+8STJFnDtn
	NJN9+SkXnBQJsYybysmjmzpbSN7fcqcINmaB
X-Google-Smtp-Source: ABdhPJwuAwtJV4Gz/7vSqarLRxbvGx5FZHkfkzGiLbXQclx8YUy5b7Mhtb/KnMBGT+lFKe1zjLXQyw==
X-Received: by 2002:a17:906:1dd1:: with SMTP id v17mr5854954ejh.31.1622836704752;
        Fri, 04 Jun 2021 12:58:24 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c047:d46c:d45:3868])
        by smtp.gmail.com with ESMTPSA id gv11sm3205481ejb.13.2021.06.04.12.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:58:24 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] mptcp: wake-up readers only for in sequence
 data.
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <5009954210af20796d1cf88ca630d19ec12e2132.1622132690.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <e21808b1-36c0-62fe-e9b2-25020573f4c7@tessares.net>
Date: Fri, 4 Jun 2021 21:58:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5009954210af20796d1cf88ca630d19ec12e2132.1622132690.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 27/05/2021 18:27, Paolo Abeni wrote:
> Currently we relay on the subflow->data_avail field,
> which is subject to races:
> 
> 	ssk1
> 		skb len = 500 DSS(seq=1, len=1000, off=0)
> 		# data_avail == MPTCP_SUBFLOW_DATA_AVAIL
> 
> 	ssk2
> 		skb len = 500 DSS(seq = 501, len=1000)
> 		# data_avail == MPTCP_SUBFLOW_DATA_AVAIL
> 
> 	ssk1
> 		skb len = 500 DSS(seq = 1, len=1000, off =500)
> 		# still data_avail == MPTCP_SUBFLOW_DATA_AVAIL,
> 		# as the skb is covered by a pre-existing map,
> 		# which was in-sequence at reception time.
> 
> Instead we can explicitly check if some has been received in-sequence,
> propagating the info from __mptcp_move_skbs_from_subflow().
> 
> Additionally and the 'ONCE' annotation to the 'data_avail' memory
> access, as msk will read it outside the subflow socket lock.
> 
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Just applied in our tree:

- 508f97cb7d94: mptcp: wake-up readers only for in sequence data
- Results: 119541ecd3c9..02c88cfc4215

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210604T195755
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210604T195755

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
