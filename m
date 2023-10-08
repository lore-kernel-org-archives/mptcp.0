Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDF3C00
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAu8IzBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BEBC433C8;
	Sun,  8 Oct 2023 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696762485;
	bh=cqMFsQGiASGKJKyzzUDQEPx0YXCXM01qgpFY7enbY2k=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hAu8IzBU30Zt71kq5SV/XRwdDc1w3yu45p1xA8iDFLENvzDmreqPwqojjYGKNm1KH
	 0hBFoCrL55S91vd6pVBS2nzM9TWAfOCDQXu8QCCuDLWm539wgu4up6wdlueUUTBMLL
	 9oj7v4GM5y53+YgO3+8AZgZwc7if/Hkef3sgP5xzxhDFaF2CsqmVsTW+5A4Tw5LtBz
	 XyudRXTNkGZ3ZUv0MjUWijYXyu38j1jh4KHAzT8fomygdiCJzVEDBzMaTiWHggg1zB
	 wygojNlpZAiXwLFFn1k1HUYpHxmQRQOzO/o+xGJdgp0ym5098ORAIKI3C9wGI0rZ3i
	 ErhONnCmZV/BQ==
Message-ID: <f4086286-6870-48a3-89a3-118efbea50fa@kernel.org>
Date: Sun, 8 Oct 2023 12:54:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 22/29] selftests: mptcp: add
 mptcp_lib_evts_*
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <8b57e996491a1057c9b1385797f7c96dec2225ed.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <8b57e996491a1057c9b1385797f7c96dec2225ed.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:42, Geliang Tang wrote:
> This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
> and mptcp_join.sh into four functions: _init, _start, _kill and _remove.
> Define them in mptcp_lib.sh and use these new helper in both scripts.

Good idea to avoid duplicated code!

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 8051ac5507dc..899c21ced5a3 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -220,6 +220,11 @@ mptcp_lib_evts_get_info() {
>  	cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
>  }
>  
> +server_evts=""
> +client_evts=""
> +server_evts_pid=0
> +client_evts_pid=0

I wonder if it wouldn't be clearer to prefix these variables with
'mptcp_lib_': we would avoid overriding global variables by mistake from
other fiels and it would be clearer to know where these variables have
been defined. But I guess if we do that, we would need to do quite a few
modifications in userspace_pm.sh and we want to avoid that, no?

Or passing them as arguments to 'mptcp_lib_evts_XXX()'? It would be more
explicit but maybe not worth it?

An alternative could be to keep these variables declared in the
different files and keep these helpers as they are here. In this case,
it would be good to add a comment before mptcp_lib_evts_init()
explaining that these variables are needed.

Please also make sure shellcheck if happy with that, e.g. by adding a
'?' in the variable name like ${server_evts?} or explicitly at the
beginning of the function with something like ': "${var?}"' or ':
"${var:?}"' if it has to be non empty, e.g.

  mptcp_lib_evts_init() {
      : "${server_evts?}"
      : "${client_evts?}"

      (...)
  }

  mptcp_lib_evts_start() {
      : "${server_evts:?}"
      : "${client_evts:?}"
      : "${server_evts_pid:?}"
      : "${client_evts_pid:?}"

      (...)
  }

  mptcp_lib_evts_kill() {
      mptcp_lib_kill_wait "${server_evts_pid:?}"
      mptcp_lib_kill_wait "${client_evts_pid:?}"
  }

  mptcp_lib_evts_remove() {
      rm -rf "${server_evts:?}" "${client_evts:?}"
  }

> +
>  mptcp_lib_kill_wait() {
>  	[ $1 -eq 0 ] && return 0
>  
> @@ -227,3 +232,38 @@ mptcp_lib_kill_wait() {
>  	kill $1 > /dev/null 2>&1
>  	wait $1 2>/dev/null
>  }
> +
> +mptcp_lib_evts_init() {
> +	if [ -z "$server_evts" ]; then

Same here and below for the {}. (see comment from patch 21/29)

+ the double quotes below to keep shellcheck happy and be safer.

> +		server_evts=$(mktemp)
> +	fi
> +	if [ -z "$client_evts" ]; then
> +		client_evts=$(mktemp)
> +	fi
> +}
> +
> +mptcp_lib_evts_start() {
> +	:>"$server_evts"
> +	:>"$client_evts"
> +
> +	if [ $server_evts_pid -ne 0 ]; then
> +		mptcp_lib_kill_wait $server_evts_pid
> +	fi
> +	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &

I think ${ns1} and ${ns2} should be passed as argument to this function.

> +	server_evts_pid=$!
> +
> +	if [ $client_evts_pid -ne 0 ]; then
> +		mptcp_lib_kill_wait $client_evts_pid
> +	fi
> +	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
> +	client_evts_pid=$!
> +}
> +
> +mptcp_lib_evts_kill() {
> +	mptcp_lib_kill_wait $server_evts_pid
> +	mptcp_lib_kill_wait $client_evts_pid

Should we eventually set the pid to 0 after that just to be on the safe
side?

  server_evts_pid=0
  client_evts_pid=0

It was not needed before, maybe fine not to do that? Up to you (but if
you do, please add a note in the commit message)

> +}
> +
> +mptcp_lib_evts_remove() {
> +	rm -rf $server_evts $client_evts
> +}

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
