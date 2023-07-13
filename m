Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F52FB3
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 16:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5BFC433C8;
	Thu, 13 Jul 2023 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689266663;
	bh=6DIm7Z5lOx8O0e0xsBbfMRrDzzXjN5nLRsmrgmUqcm8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jXvGiJEUd51T+RbevCWasocOXSCzjSkdjAhyWCwWMTS+XFkkHWa4SRtsZXGTl4uTF
	 IBT09cPiMlLSiblXE2/7vHNYVkbOoPu4Wl0JpOqBMYtP3sN1Akf0iExIQc+7KSUzBN
	 eTLVP4cQgKS/bL3bWOnd15D0gabhiwcwnwICKhushMDZTciXDwckJp3g5Id8VT+vhy
	 se9BR92gZ3FEmtlSLMOFtUAZn5jSOSUAZlp7IGJUnv4kcxVmpaYDTVPm+gnAE9y5JW
	 jFwCDvX2gsPmAqpC1ne+QjqgGG2HvOfQT33PILRaK2MFJpTBdYI6XTW160s9WKmMzG
	 SWApRVYdfo/ew==
Date: Thu, 13 Jul 2023 09:44:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 01/14] mptcp: more accurate NL event
 generation.
In-Reply-To: <5b02d760-9820-31c2-6e2f-65560673cdc9@tessares.net>
Message-ID: <466f8c99-5e4b-77ad-2e73-19541904ae1b@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com> <2dff178d492953373f5d7215aea15676b0e6079c.1688993569.git.pabeni@redhat.com> <5b02d760-9820-31c2-6e2f-65560673cdc9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 13 Jul 2023, Matthieu Baerts wrote:

> Hi Paolo, Mat,
>
> On 10/07/2023 14:54, Paolo Abeni wrote:
>> Currently the mptcp code generate a "new listener" event even
>> if the actual listen() syscall fails. Address the issue moving
>> the event generation call under the successful branch.
>
> Good catch!
>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> this could possibly go via -net, but is used by later patches and
>> is not really critical IMHO.
>> Eventually the additional tag would be:
>> Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
>
> I think it makes sense to send this to -net. If it is OK for Mat, I can
> already apply this patch.

Sure, fine to apply this one.


- Mat

