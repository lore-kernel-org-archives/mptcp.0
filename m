Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7464A28
	for <mptcp@lists.linux.dev>; Sat, 18 Jan 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737197693; cv=none; b=p4hMeVMKoxTVMBGKzmgQlyHp6kv3q++W56yTtWgvvYoznALoMLJTtWWi9umBNzKKR/8IrMGOYB5q6z+gcNShLkVnCqVnw7t98+wZEU7uKZbewZIpls0Zlr+NNx9zdUAiieL5EZmuRvRf6kuCupfUbfmzaPFtWjMfdE4PFxMZslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737197693; c=relaxed/simple;
	bh=jMIhkcXvwiLT/ou0DSUWDkPE+4+Imfhwn204M+FWdL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eebp1Mb+tltRkfAt4OCn/CTYSbEmYTWevU1BgGGdaF5cgNurqbzqg6hTIYJ09qfMrpoczzFlPbFFLxXa+zEQUBfPJ+cZkuXGPb7UTIOyZ8AMdBUR8BJkQUCjsj6FJW4e48WcwfZqmjiydL1JU9pNPXu2Nr+UVfsg56KKU4otV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi9JA5hP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi9JA5hP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B253C4CED1;
	Sat, 18 Jan 2025 10:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737197692;
	bh=jMIhkcXvwiLT/ou0DSUWDkPE+4+Imfhwn204M+FWdL8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Mi9JA5hPAaMaFvIqVtN3UA+erYQefu6zcuMYD6FcBqHh15QHYMuduqeGgOvC95Ub1
	 xmhNljpAjwontpsIBbBmUjETCWZL6e12ZdZpw1z5C9+KmWXPe/MHzY22aQ2Mv+n+HJ
	 bhmn54CD+bOZjBRRUcXxIGaZe8FVByosasgGiJcTpXpcxWxsz2zWbx6yByQ5thoNEK
	 C+oNa00fP13cBzsmroxqrgDH6xAA3Ad2gZhuIi7HJshD7tRBET35DRT0eQuj868DUN
	 ZvQBGeiqQNsdVhxUcNXR34eSNptafqodPEevKWXdinTkFLKJ5EOokhzmFarnQo/DOw
	 fK4Z0azX3CiYQ==
Message-ID: <44df209fd690c009ddbcafd5e2a6872b987da4e2.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: pm: add id parameter for
 get_addr"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sat, 18 Jan 2025 18:54:49 +0800
In-Reply-To: <e34a54e2-bf7b-47eb-89ac-80e5605955aa@kernel.org>
References: 
	<625cc0fceb9d347ed6a029396a8d202cbb24d2c4.1737156352.git.tanggeliang@kylinos.cn>
	 <e34a54e2-bf7b-47eb-89ac-80e5605955aa@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Sat, 2025-01-18 at 08:50 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 18/01/2025 00:26, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > No need to drop 'attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];' in
> > mptcp_userspace_pm_get_addr() too, add it back.
> > 
> > Alse update mptcp_pm_nl_get_addr() to keep the original two-line
> > assignment of 'attr'.
> 
> I did a simple fix instead, see 648a0809e4cf ("Squash to "mptcp: pm:
> add
> id parameter for get_addr"") and the final export branch. Tell me if
> that's not OK.

It works.

But we just change

	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];

to
	struct nlattr *token;

	token = info->attrs[MPTCP_PM_ATTR_TOKEN];

in patch 5 "mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK".

We change it back again in this patch 11.

So I prefer to use the two-line assignment of 'attr'. But up to you.

Thanks,
-Geliang

> 
> Cheers,
> Matt

