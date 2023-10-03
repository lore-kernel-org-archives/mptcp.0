Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636930CF2
	for <mptcp@lists.linux.dev>; Tue,  3 Oct 2023 16:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E0AC433C8;
	Tue,  3 Oct 2023 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696351516;
	bh=1pdWveMouH6+xMe3uSYad8aDUnKGEZ/MrVFX2cH5/5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FiMWQyJVm+jLVz3wkP9uwaM5aUp/N700UE1TR6nkm34/+cawSLCtDDHttk8YgInlq
	 a93Df/9FzzHc234KCizXRpre2CEbhKIcfuQrePixTQF7W0D3Ab83nDeNQ6TO8BvKVj
	 wuZ72IPb87dCeSlKiYIKS+hAFPF8fVHmDAZ6qzOBAMcHQlbMj1KmQEz/RQ8AU8ezvE
	 C2zBEJ2Q1juJFe1ixyj1UPkTPq8zpOhH4xjrV7C7Hj5SA9JLTkQcQ9n6YzAF5w0caJ
	 DfVbvww/C/qmgJTt0gGKpxNKoDD1In1PFCVUwOfLYvZw8sB8yde1Ww/3ukmU7ijhDF
	 9cSFBdczyl1/A==
Message-ID: <aae44a65-266c-43d9-8762-ff4e171f9334@kernel.org>
Date: Tue, 3 Oct 2023 18:45:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 1/2] tcp: define initial scaling factor
 value as a macro
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <c71297499300a20bc41fe9c526d4a6cad08c176f.1696237983.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Organization: Tessares
In-Reply-To: <c71297499300a20bc41fe9c526d4a6cad08c176f.1696237983.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 02/10/2023 11:13, Paolo Abeni wrote:
> So that other users could access it. Notably MPTCP will use
> it in the next patch.
> 
> No functional change intended.

Thank you for the new version, it looks good to me!

Acked-by: Matthieu Baerts <matttbe@kernel.org>

Cheers,
Matt
