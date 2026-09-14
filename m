Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4A2EA173
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378326; cv=none; b=OUVEo1kZ4aUbZbn3ZYfMpAlpuOYqrNlwuoS+ZF+xSeomf7513fsTa6Msj5uUlNLUVSsZ9yzXwi6wtufYdyTJD3dn0hFNF0jRLylt2GfrM/5yKrSE9jubn+7+Hj+gEpXnaxui0KxgSNwFA3ALGyxtVKGVOXHUSU0bjMyR1yS2sns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378326; c=relaxed/simple;
	bh=mOimL6nZToxkBswzsqVEJRG9uOrHm/gPGho+T5kw07w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e1LQ3lw9kc8p4P676y09CDYBl6s9bygFVlyUUTVg5ChzgUSzF/4OPaLnqF7hj5rBlMyayDuFurxjsZrM0di44rnNTfgLeoCefxixjaXAKHxGqKqzujykdI6rvSFphE9XeiUDxvj5cQ8wKv8cCAQYAQGwaSBkgPz6Jfx8H0Msjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9xIAaah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9xIAaah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113E81F000FF;
	Mon, 14 Sep 2026 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378325;
	bh=XKusrBTFnUCsYX7FgVDpwGyDotrEKMwEMtAtlpPTUGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9xIAaah1t8wDyA1UyllNJo51KXeCXKIxIG3xEtu5rY41NbCTgJfQowBHf4ooiyoO
	 lR5NXMEt7qvh2qyDbSbLA/qywF5HQYIQYSl1078jHpE+/Z35ppvvBr1RScmcWpBLks
	 umYpTgw+UV0qYl4vHDbWO7IoYvLflkKeRp+MYp96gKZVB4fuy8k7OvJwxNIdjEVLcq
	 5/RVJJAES+pDkYrkdyrUic2awoUANfi6nPxxQceewsmmaXg/tLf6w/1902YG7sOFDQ
	 9bWxGZaEIy9SICmWr9h+tDwpBeBoqeAy6V0sONeUwOH/nGaDgMGgO9s+eOFMUGmYHt
	 JUVFhAdEW50qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 2/2] selftests: mptcp: bpf: exercise the
 subflow avoid flag across rounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260914092000.1306968-3-kalpan.jani@mpiricsoftware.com>
References: <20260914092000.1306968-1-kalpan.jani@mpiricsoftware.com>
 <20260914092000.1306968-3-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:32:04 +0000
Message-Id: <20260914093205.113E81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `test_avoid` selftest contains fundamental logic flaws that =
cause it to silently pass without ever exercising the `avoid` functionality=
, resulting in a false positive test.
--

commit 23085ecdc8efb175d47c716d935708a8072a4cd5
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

This commit adds a BPF struct_ops scheduler selftest for=20
mptcp_subflow_set_avoid(). It attempts to mark subflows as avoided during t=
he
first scheduling round and verifies they are skipped in subsequent rounds.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_avoid.c
> new file mode 100644
> index 0000000000000..359b515800875
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

[ ... ]

> +SEC("struct_ops")
> +int BPF_PROG(bpf_avoid_get_send, struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_avoid_storage *ptr;
> +
> +	ptr =3D bpf_sk_storage_get(&mptcp_avoid_map, msk, 0,
> +				 BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!ptr)
> +		return -1;
> +
> +	/*
> +	 * set once, on the first scheduling round, never touched again --
> +	 * this is what makes "avoid" different from "scheduled": nothing
> +	 * here re-asserts the decision, and the core doesn't clear it
> +	 * either.
> +	 */
> +	if (!ptr->avoid_marked) {
> +		int i =3D 0;
> +
> +		/* bench every subflow but the first, once */
> +		bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
> +			if (i++ > 0)
> +				mptcp_subflow_set_avoid(subflow, true);
> +		}
> +		ptr->avoid_marked =3D true;
> +	}

[Severity: Medium]
Since bpf_avoid_get_send() is called immediately when the first subflow is=
=20
established (and before the second subflow finishes its MP_JOIN), is `i++ >=
 0`=20
ever true here?

If there is only one subflow when this initialization block runs, `avoid` w=
ill=20
never be set for any subflow, but `avoid_marked` becomes true, which perman=
ently=20
locks out this block.

> +
> +	/*
> +	 * every round -- including this one -- just reads back state set
> +	 * at most once above. no re-assertion, ever.
> +	 */
> +	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
> +		if (subflow->avoid)
> +			continue;
> +		if (mptcp_subflow_active(subflow)) {
> +			mptcp_subflow_set_scheduled(subflow, true);
> +			break;
> +		}
> +	}
> +	return 0;
> +}

[Severity: Medium]
Because the first subflow is never marked to be avoided, does this loop alw=
ays=20
break on the first active subflow?

Since the first subflow naturally handles the entire data transfer, it is a=
lways=20
selected, and the second subflow is never evaluated. Does this cause the te=
st=20
to artificially pass and provide a false positive result, regardless of whe=
ther=20
the `avoid` feature actually works?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092000.1306=
968-1-kalpan.jani@mpiricsoftware.com?part=3D2
