Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C331A82
	for <mptcp@lists.linux.dev>; Tue,  3 Oct 2023 16:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644E0C433C9;
	Tue,  3 Oct 2023 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696351378;
	bh=IYTfRR6RkNCj1iPSOlZhZYIRbCIruM1tJLpE46gAnmo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=g4zWHrI4Km+11RWfLnRS6e6++FYEaTSBharmQTtJ5/BkXmO4Ve/Ck5dO5ehtzes3o
	 m6LqYGms81KW2sZvnwYATh5Swpyxti63oGYG2pU9gV2/DS1TTgsqCVMt1fE9baZEQi
	 MaDdF7eGthKldC+1lRD8uIgvY8lrUYP8rmLF29u/27lVqNDlBTwW6LNNid6RCh0V19
	 zkDg1Eni1GNfmeCp6xqzn8B7pebbYp70RwZsdvUfwCczDlvTNmA6lU+YLrZ/oYfAUl
	 eQ670hkFRLZ2omu5xAF4rEQTMBD5H4Sj0Qtjs8x0nJUfWiDdJ2EOMavENHO8ko15Wo
	 hJ6iLlN/67TTg==
Message-ID: <e20d06ff-52dd-4383-ac4f-e070f3171dbb@kernel.org>
Date: Tue, 3 Oct 2023 18:42:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: update userspace
 pm test helpers"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <7a8234908b8198636e231d1ce6e42ab6d5864d0e.1696062626.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Organization: Tessares
In-Reply-To: <7a8234908b8198636e231d1ce6e42ab6d5864d0e.1696062626.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/09/2023 10:30, Geliang Tang wrote:
> Put MPTCP event macros together.

Thank you for the follow-up patch, good idea, I missed that!

New patches for t/upstream:
- 114421ed8ba7: Squash to "selftests: mptcp: update userspace pm test
helpers"
- Results: 9de414b56675..3cbb19268039 (export)

Cheers,
Matt
