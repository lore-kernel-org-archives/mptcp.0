Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538923775
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoUwnAAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24E2C433C7;
	Mon, 16 Oct 2023 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697456048;
	bh=DWZkB5XsFgsMufclBv27WVlqbxRNxeaHJlLv2ZbPuIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EoUwnAAGwwEoI7hDfD6F+DnZxeXYwgBOs6kwlYHRDbGOD7jLlRAE1j0pZ1aRVVfOL
	 gWbIkByUyhjuKtGjtZVCD2LRgwzvB93lNrbJBQH73KOf2VwEZ/NtUPyGM/RKD5UGNT
	 PahjFPpSezi4bnzfzGK37MhK+nUDGBk80JdzLII3Q4v/4Y2+zH3rqB6cnqMBXoe5wQ
	 M7bfFK3D7j2cpGTgytfeLE+1S9NMXGgS62LaTYcMkUdRKuvPvkrkUO58vKb1Ft0Oy0
	 IoS5k/X8DZ4YtDTbl9vHorXs0Qeo2duuV//rXnswWwa+7Ie5JkwyCQOT8qa8iiO6m/
	 qRePDNwmSHA+A==
Message-ID: <439ff464-675a-40d7-9c1b-3e8224a23be2@kernel.org>
Date: Mon, 16 Oct 2023 13:34:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] Squash to: "net: mptcp: use policy generated
 by YAML spec"
Content-Language: en-GB, fr-BE
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
References: <36fe14dbd444daf86a22cfa5fb50d590324e7b58.1697190267.git.dcaratti@redhat.com>
 <ee31bfb2-9fe0-4d20-ad6f-1627d048613d@kernel.org>
 <CAKa-r6vwzXYMcn7aP_ap+aHsApCngjwBRraUEk=zQSV2WngJ3g@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <CAKa-r6vwzXYMcn7aP_ap+aHsApCngjwBRraUEk=zQSV2WngJ3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Davide,

On 13/10/2023 17:53, Davide Caratti wrote:
> hello Matthieu,
> 
> On Fri, Oct 13, 2023 at 5:07 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Davide,
>>
> 
>>
>> I'm not sure to understand your modification: is it just a test patch to
>> check that the CI is OK with the modifications, or do you want to have
>> this patch included in the tree?
> 
> yes the goal was to check NLA_POLICY_EXACT_LEN() with CI (we already
> have it, but better to double check on top of the whole series).
> By the way , I see a failure but it doesn't seem real (I hope :) )

Good!

>> Because I guess we cannot just accept this patch, we also need a
>> modification of the YAML spec and the YNL tool. Then this file you
>> modified here will be re-generated, and we will get this new result, no?
> 
> right, I have a series ready that also includes the parser of
> 'exact-len:' key in specfiles (and a de-uglified yaml spec, as per
> Jakub's comment). If you are ok with it, I will send this series
> directly to netdev - then, 'export' and 'net-next' will slightly
> differ until the next merge. Let me know if that is ok for you,

I would prefer to have squash-to patches, so we can easily review the
modifications and apply them in our tree before sending them to
'net-next' (or this last step in parallel). Also, by doing that, the
MPTCP CI will be able to validate the modifications.

If a different version is applied in net-next, the MPTCP tree will no
longer be in sync: it means the CI might not be able to automatically
sync with net-next and manual steps might be required.

But if the series had a lot of modifications and having squash-to
patches no longer make sense, we can work around that: reverting the
different patches one by one, resolving manually the conflicts, etc. I
can also try to apply a v2, but again, with manually steps :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
