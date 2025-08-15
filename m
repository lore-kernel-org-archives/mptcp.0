Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A2DF71
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246266; cv=none; b=jHkrRmPLYu8Cjk+8QseU9xeisARVaQ4mHnSdNAH8mItG5l2qhqmQJGh0dHAAJ64rZC1qH7FNIxXruKMjBTDiLuidm1qg19HEF5N8RlE2UNCDPYDSOasfaZrLOfWkpgfGxMTtRPdXaGTeFR5lTfxfgPoKE88pxQSNRSqWb64tJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246266; c=relaxed/simple;
	bh=4WOuwwN8NVT+uH9g5Uw3jgxIdnvFFyv21npqyJkB6Vs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LEEyU8aqfPaAoL/RJOcQJr0JALvsdalyDrgkezAe+snaj75Ga822iuoNTQJI0V2i7DuBxkam6Kiq6YK7uXuNmjJ2s4S4fjol3mydovG37uxI5zUhTvyy30qxvTN31oom83f7ayukqlxXhhl/cgiVYbjcLHKBpLAWVP+obywQzb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPDwMbBI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPDwMbBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35F8C4CEEB;
	Fri, 15 Aug 2025 08:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755246265;
	bh=4WOuwwN8NVT+uH9g5Uw3jgxIdnvFFyv21npqyJkB6Vs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SPDwMbBI7sw7HZBlRAoiLpGUuKzPrz+rAtDehImI+WoDZoZAGk3TzBPW3ZpuHrsDR
	 gguvPs83qKkBUpER3C78Ds9j8N6aCUh0Wffua6X4z9LPdwj4goA6ca6ghelGsqQEHX
	 /GULBOo+xEIAKp1doHHfd7c5mAAuE+VeqxmTMjkGtpSPvOUkCKzVEhyfsEzMbSM6kr
	 ZfnC7ejHrXnUwVD1ftoKDBRIn6XJxxJqfKcaBekTATNwUfhMDWg8arE2AdOibf4VFE
	 ENzJO21j0MokgpTRpbqRp7krKdgq5U1y4iaHRBAomTFfawNAf6j++eaOUhWi8h+57l
	 ee5QPyr39sE7Q==
Date: Fri, 15 Aug 2025 10:24:18 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Message-ID: <62e44bb3-957d-4676-95ec-2ceedba2e9c1@kernel.org>
In-Reply-To: <20250815073140.29077-1-yangang@kylinos.cn>
References: <20250815073140.29077-1-yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3] selftests: net: mptcp: add checks for
 fallback counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <62e44bb3-957d-4676-95ec-2ceedba2e9c1@kernel.org>

Hi Gang,

15 Aug 2025 09:32:11 Gang Yan <yangang@kylinos.cn>:

> Recently, some mib counters about fallback has been added, this patch
> provides a method to check the expected behavior of these mib counters
> during the test execution.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/571
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
>
> ------
> Changelog:
> =C2=A0 v3:
> =C2=A0=C2=A0=C2=A0 - Squash into a single patch.
> =C2=A0=C2=A0=C2=A0 - Using 'fb_' as a prefix instead of the suffix for va=
riables.
> =C2=A0=C2=A0=C2=A0 - Adjust the order of mib counters to check, ensuring =
it matches the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variable declaration.
> =C2=A0=C2=A0=C2=A0 - The namespace('ns1'/'ns2') is included in the output=
 of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'chk_fallback_nr', like:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ns2 infinite map tx fallback=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [IGNO] (flaky) got 1 infinite map tx fallbac=
k[s] in ns2 expected 0"
> =C2=A0=C2=A0=C2=A0 - Add a new helper named 'chk_fallback_nr_all', which =
prints only
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when an error occurs.
> =C2=A0=C2=A0=C2=A0 - Fix some code style issues.

Thank you for the new version!

> =C2=A0 v2:
> =C2=A0=C2=A0=C2=A0 - add a helper which can check all the fallback mib co=
unters.
> =C2=A0=C2=A0=C2=A0 - put the 'chk_fallback_nr' in 'chk_join_nr' like chk_=
join_tx_nr.
>
> Notes:
>
> Hi Matt,
>
> I wanted to apologize for splitting the changes into multiple commits,
> my intention was to ease the review process, but it unfortunately
> backfired.

That's OK, no need to apologize, I was just trying to explain when
splitting makes sense or not.

> Thanks for your valuable suggestions, I've made some improvements based
> on your feedback.
>
> Please take another look at the updated changes.
>
> Best regards,
> Gang
>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 123 ++++++++++++++++++
> 1 file changed, 123 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index b8af65373b3a..898779a9af58 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -74,6 +74,17 @@ unset join_create_err
> unset join_bind_err
> unset join_connect_err
>
> +unset fb_ns1
> +unset fb_ns2
> +unset fb_infinite_map_tx
> +unset fb_dss_corruption
> +unset fb_simult_conn
> +unset fb_mpc_passive
> +unset fb_mpc_active
> +unset fb_mpc_data
> +unset fb_md5_sig
> +unset fb_dss
> +
> # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x30) ||
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (ip6 && (ip6[74] & 0xf0) =3D=3D 0x30)'"
> CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"14,
> @@ -1399,6 +1410,115 @@ chk_join_tx_nr()
> =C2=A0=C2=A0=C2=A0 print_results "join Tx" ${rc}
> }
>
> +chk_fallback_nr()
> +{
> +=C2=A0=C2=A0 local infinite_map_tx=3D${fb_infinite_map_tx:-0}
> +=C2=A0=C2=A0 local dss_corruption=3D${fb_dss_corruption:-0}
> +=C2=A0=C2=A0 local simult_conn=3D${fb_simult_conn:-0}
> +=C2=A0=C2=A0 local mpc_passive=3D${fb_mpc_passive:-0}
> +=C2=A0=C2=A0 local mpc_active=3D${fb_mpc_active:-0}
> +=C2=A0=C2=A0 local mpc_data=3D${fb_mpc_data:-0}
> +=C2=A0=C2=A0 local md5_sig=3D${fb_md5_sig:-0}
> +=C2=A0=C2=A0 local dss=3D${fb_dss:-0}
> +=C2=A0=C2=A0 local rc=3D${KSFT_PASS}
> +=C2=A0=C2=A0 local ns=3D$1
> +=C2=A0=C2=A0 local count
> +
> +=C2=A0=C2=A0 count=3D$(mptcp_lib_get_counter ${!ns} "MPTcpExtInfiniteMap=
Tx")
> +=C2=A0=C2=A0 if [ -z "$count" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_SKIP}
> +=C2=A0=C2=A0 elif [ "$count" !=3D "$infinite_map_tx" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_FAIL}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_check "$ns infinite map tx fa=
llback"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_test "got $count infinite map =
tx fallback[s] in $ns expected $infinite_map_tx"
> +=C2=A0=C2=A0 fi
> +
> +=C2=A0=C2=A0 count=3D$(mptcp_lib_get_counter ${!ns} "MPTcpExtDSSCorrupti=
onFallback")
> +=C2=A0=C2=A0 if [ -z "$count" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_SKIP}
> +=C2=A0=C2=A0 elif [ "$count" !=3D "$dss_corruption" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_FAIL}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_check "$ns dss corruption fal=
lback"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_test "got $count dss corruptio=
n fallback[s] in $ns expected $dss_corruption"
> +=C2=A0=C2=A0 fi
> +
> +=C2=A0=C2=A0 count=3D$(mptcp_lib_get_counter ${!ns} "MPTcpExtSimultConne=
ctFallback")
> +=C2=A0=C2=A0 if [ -z "$count" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_SKIP}
> +=C2=A0=C2=A0 elif [ "$count" !=3D "$simult_conn" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_FAIL}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_check "$ns simult conn fallba=
ck"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_test "got $count simult conn f=
allback[s] in $ns expected $simult_conn"
> +=C2=A0=C2=A0 fi
> +
> +=C2=A0=C2=A0 count=3D$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFa=
llbackACK")
> +=C2=A0=C2=A0 if [ -z "$count" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_SKIP}
> +=C2=A0=C2=A0 elif [ "$count" !=3D "$mpc_passive" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_FAIL}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_check "$ns mpc passive fallba=
ck"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_test "got $count mpc passive f=
allback[s] in $ns expected $mpc_passive"
> +=C2=A0=C2=A0 fi
> +
> +=C2=A0=C2=A0 count=3D$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFa=
llbackSYNACK")
> +=C2=A0=C2=A0 if [ -z "$count" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_SKIP}
> +=C2=A0=C2=A0 elif [ "$count" !=3D "$mpc_active" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_FAIL}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_check "$ns mpc active fallbac=
k"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_test "got $count mpc active fa=
llback[s] in $ns expected $mpc_active"
> +=C2=A0=C2=A0 fi
> +
> +=C2=A0=C2=A0 count=3D$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableDa=
taFallback")
> +=C2=A0=C2=A0 if [ -z "$count" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_SKIP}
> +=C2=A0=C2=A0 elif [ "$count" !=3D "$mpc_data" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_FAIL}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_check "$ns mpc data fallback"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_test "got $count mpc data fall=
back[s] in $ns expected $mpc_data"
> +=C2=A0=C2=A0 fi
> +
> +=C2=A0=C2=A0 count=3D$(mptcp_lib_get_counter ${!ns} "MPTcpExtMD5SigFallb=
ack")
> +=C2=A0=C2=A0 if [ -z "$count" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_SKIP}
> +=C2=A0=C2=A0 elif [ "$count" !=3D "$md5_sig" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_FAIL}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_check "$ns MD5 Sig fallback"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_test "got $count MD5 Sig fallb=
ack[s] in $ns expected $MD5_Sig"

Should be $md5_sig without capital letters. I wonder if shellcheck
will detect this.

If the CI is happy with this version, I can do the modification when
applying the patch.

Cheers,
Matt

> +=C2=A0=C2=A0 fi
> +
> +=C2=A0=C2=A0 count=3D$(mptcp_lib_get_counter ${!ns} "MPTcpExtDssFallback=
")
> +=C2=A0=C2=A0 if [ -z "$count" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_SKIP}
> +=C2=A0=C2=A0 elif [ "$count" !=3D "$dss" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=3D${KSFT_FAIL}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_check "$ns dss fallback"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_test "got $count dss fallback[=
s] in $ns expected $dss"
> +=C2=A0=C2=A0 fi
> +
> +=C2=A0=C2=A0 return $rc
> +}
> +
> +chk_fallback_nr_all()
> +{
> +=C2=A0=C2=A0 local netns=3D("ns1" "ns2")
> +=C2=A0=C2=A0 local fb_ns=3D("fb_ns1" "fb_ns2")
> +=C2=A0=C2=A0 local rc=3D${KSFT_PASS}
> +
> +=C2=A0=C2=A0 for i in 0 1; do
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -n "${!fb_ns[i]}" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eval "${!fb=
_ns[i]}" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 chk_fallback_nr ${netns[i]} || rc=3D{?}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_fallbac=
k_nr ${netns[i]} || rc=3D{?}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> +=C2=A0=C2=A0 done
> +
> +=C2=A0=C2=A0 if [ "$rc" !=3D "${KSFT_PASS}" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_results "fallback" $rc
> +=C2=A0=C2=A0 fi
> +}
> +
> chk_join_nr()
> {
> =C2=A0=C2=A0=C2=A0 local syn_nr=3D$1
> @@ -1484,6 +1604,8 @@ chk_join_nr()
> =C2=A0=C2=A0=C2=A0 join_syn_tx=3D"${join_syn_tx:-${syn_nr}}" \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_join_tx_nr
>
> +=C2=A0=C2=A0 chk_fallback_nr_all
> +
> =C2=A0=C2=A0=C2=A0 if $validate_checksum; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_csum_nr $csum_ns1 $csum_ns=
2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_fail_nr $fail_nr $fail_nr
> @@ -3337,6 +3459,7 @@ fail_tests()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 join_csum_ns1=3D+1 join_csum_n=
s2=3D+0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 join_f=
ail_nr=3D1 join_rst_nr=3D0 join_infi_nr=3D1 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 join_c=
orrupted_pkts=3D"$(pedit_action_pkts)" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fb_ns1=3D"f=
b_dss=3D1" fb_ns2=3D"fb_infinite_map_tx=3D1" \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_jo=
in_nr 0 0 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_fail_nr 1 -1 invert
> =C2=A0=C2=A0=C2=A0 fi
> --
> 2.43.0

