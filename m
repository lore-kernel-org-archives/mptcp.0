Content-Type: multipart/mixed; boundary="===============0328290055229844476=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 7/9] mptcp: add netlink based PM
Date: Wed, 26 Feb 2020 12:44:13 +0100
Message-ID: <4f111fb6-2ec9-8ab0-4543-46161995a13a@tessares.net>
In-Reply-To: 8096c62ca92b5ca5e16fc7caa3e60fedb2beb2fb.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3810

--===============0328290055229844476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 26/02/2020 12:36, Paolo Abeni wrote:
> On Mon, 2020-02-24 at 16:51 +0100, Paolo Abeni wrote:
>> +enum {
>> +	MPTCP_PM_CMD_UNSPEC,
>> +
>> +	MPTCP_PM_CMD_ADD_ADDR,
>> +	MPTCP_PM_CMD_DEL_ADDR,
>> +	MPTCP_PM_CMD_GET_ADDR,
>> +	MPTCP_PM_CMD_FLUSH_ADDRS,
>> +	MPTCP_PM_CMD_SET_RCV_ADD_ADDRS,
>> +	MPTCP_PM_CMD_GET_RCV_ADD_ADDRS,
> =

> To enforce the server subflow limits, the idea would be to change (in a
> separated series) the above 2 commands to:
> 	MPTCP_PM_CMD_SET_LIMITS,
> 	MPTCP_PM_CMD_GET_LIMITS,
> =

> and add a new attribute for the max subflow limits
> =

> Plus the core infrastructure/hooks to let the PM really enforce such
> limit.
> =

> WDYT?

That sounds good to me and more "natural". Thank you for looking at this!

Just one question: would they be generic commands to add/get limits? Or =

should we set a more specific name, e.g.:

   MPTCP_PM_CMD_SET_MAX_SUBFLOWS
   MPTCP_PM_CMD_GET_MAX_SUBFLOWS

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0328290055229844476==--
